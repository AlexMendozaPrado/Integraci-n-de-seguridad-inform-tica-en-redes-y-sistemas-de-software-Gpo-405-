// AuthService.swift
// Threads
//
//

import Firebase

class AuthService {
    // MARK: - Published Properties

    @Published var userSession: FirebaseAuth.User? // This published property stores the current user's session.

    // MARK: - Static Properties

    static let shared = AuthService() // This static property provides a singleton instance of the AuthService class.

    // MARK: - Initialization

    init() {
        // Sets the userSession property to the current user's session.
        self.userSession = Auth.auth().currentUser

        // Fetches the current user's data from Firestore.
        Task { try await UserService.shared.fetchCurrentUser() }
    }

    // MARK: - Public Methods

    @MainActor
    func login(withEmail email: String, password: String) async throws {
        // Attempts to sign in the user with the given email and password.
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)

            // Sets the userSession property to the signed-in user's session.
            self.userSession = result.user

            // Fetches the signed-in user's data from Firestore.
            try await UserService.shared.fetchCurrentUser()
        } catch {
            // Prints the error to the console.
            print("DEBUG: Failed to login with error \(error.localizedDescription)")

            // Throws the error.
            throw error
        }
    }

    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        // Attempts to create a new user with the given email, password, fullname, and username.
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)

            // Sets the userSession property to the newly created user's session.
            self.userSession = result.user

            // Uploads the newly created user's data to Firestore.
            try await uploadUserData(email: email, fullname: fullname, username: username, id: result.user.uid)
        } catch {
            // Prints the error to the console.
            print("DEBUG: Failed to login with error \(error.localizedDescription)")

            // Throws the error.
            throw error
        }
    }

    @MainActor
    private func uploadUserData(email: String, fullname: String, username: String, id: String) async throws {
        // Creates a User object with the given email, fullname, username, and id.
        let user = User(fullname: fullname, email: email, username: username.lowercased(), id: id)

        // Encodes the User object into JSON data.
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }

        // Saves the user's data to Firestore.
        try await FirestoreConstants.UserCollection.document(id).setData(encodedUser)

        // Sets the current user in the UserService class.
        UserService.shared.currentUser = user
    }

    func signOut() {
        // Attempts to sign out the current user.
        do {
            try Auth.auth().signOut()

            // Sets the userSession property to nil.
            self.userSession = nil
        } catch {
            // Prints the error to the console.
            print("DEBUG: Failed to sign out")
        }
    }

    func sendPasswordResetEmail(toEmail email: String) async throws {
        // Attempts to send a password reset email to the given email address.
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            // Prints the error to the console.
            print("DEBUG: Failed to send email with error \(error.localizedDescription)")

            // Throws the error.
            throw error
        }
    }
}
