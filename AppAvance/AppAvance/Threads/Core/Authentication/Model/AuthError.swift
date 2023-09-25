// AuthError.swift
// Threads
//
//

import Foundation
import Firebase

enum AuthError: Error {
    // MARK: - Cases

    case invalidEmail
    case invalidPassword
    case userNotFound
    case weakPassword
    case unknown

    // MARK: - Initialization

    init(authErrorCode: AuthErrorCode.Code) {
        // Converts the Firebase AuthErrorCode to an AuthError case.
        switch authErrorCode {
        case .invalidEmail:
            self = .invalidEmail
        case .wrongPassword:
            self = .invalidPassword
        case .weakPassword:
            self = .weakPassword
        case .userNotFound:
            self = .userNotFound
        default:
            self = .unknown
        }
    }

    // MARK: - Computed Properties

    var description: String {
        // Returns a description of the AuthError case.
        switch self {
        case .invalidEmail:
            return "The email you entered is invalid. Please try again"
        case .invalidPassword:
            return "Incorrect password. Please try again"
        case .userNotFound:
            return "It looks like there is no account associated with this email. Create an account to continue"
        case .weakPassword:
            return "Your password must be at least 6 characters in length. Please try again."
        case .unknown:
            return "An unknown error occured. Please try again."
        }
    }
}
