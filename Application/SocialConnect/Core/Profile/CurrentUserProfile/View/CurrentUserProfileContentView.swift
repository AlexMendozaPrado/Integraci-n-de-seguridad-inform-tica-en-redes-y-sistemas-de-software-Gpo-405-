import SwiftUI

enum CurrentUserProfileSheetConfig: Identifiable {
    case editProfile
    
    var id: Int { return hashValue }
}

struct CurrentUserProfileContentView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var sheetConfig: CurrentUserProfileSheetConfig?
    
    @Binding var userId: String
    @Binding var userEmail: String
    @Binding var userFirstName: String
    @Binding var userLastName: String
    @Binding var userPhoneNumber: String
    @Binding var userRole: String
    @Binding var userImageUrl: String
    @Binding var isOrganization: Bool
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Spacer()
                
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "list.bullet")
                        .foregroundColor(Color.theme.primaryText)
                }
                .padding(.leading, 16)
                .padding(.trailing, 8)
            }
            .padding(.all)
            
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text((user?.firstName ?? "") + (user?.lastName ?? ""))
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text(user?.email ?? "")
                                .font(.subheadline)
                        }
                        
                        if let phoneNumber = user?.phoneNumber {
                            Text(phoneNumber)
                                .font(.footnote)
                        }
                    }
                    
                    Spacer()
                    
                    CircularProfileImageView(logoUrl: user?.imageUrl, size: .medium)
                }
                
                HStack {
                    Button(action: {
                        sheetConfig = .editProfile
                    }) {
                        HStack {
                            Image(systemName: "pencil")
                            Text("Modificar perfil")
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 175, height: 32)
                        .foregroundColor(.white)
                        .background(Color.cyan)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Compartir Perfil")
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 175, height: 32)
                        .foregroundColor(.white)
                        .background(Color.cyan)
                        .cornerRadius(10)
                    }
                }
                
                Divider()
                
                displayAppStorageData()
                
                if let user = user {
                    UserContentListView(viewModel: UserContentListViewModel(user: user))
                }
            }
            .padding(.all)
        }
        .background(Background())
        .sheet(item: $sheetConfig, content: { config in
            switch config {
            case .editProfile:
                EditProfileView()
                    .environmentObject(viewModel)
            }
        })
    }
    
    func displayAppStorageData() -> some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.cyan)
                Text("E-mail: \(userEmail)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("PrimaryText"))
            }
            
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.cyan)
                Text("Nombre: \(userFirstName) \(userLastName)")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(Color("PrimaryText"))
            }
            .padding(.horizontal)
            
            HStack {
                Image(systemName: "phone")
                    .foregroundColor(.cyan)
                Text("Telefono: \(userPhoneNumber)")
                    .font(.title3)
                    .foregroundColor(Color("PrimaryText"))
            }
            
            if !userImageUrl.isEmpty {
                AsyncImage(url: URL(string: userImageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                    case .failure:
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.cyan)
                    }
                }
            }
        }
        .padding()
    }
}

struct CurrentUserProfileContentView_Previews: PreviewProvider {
    @State static var dummyUserId: String = "12345"
    @State static var dummyUserEmail: String = "email@example.com"
    @State static var dummyUserFirstName: String = "John"
    @State static var dummyUserLastName: String = "Doe"
    @State static var dummyUserPhoneNumber: String = "+1234567890"
    @State static var dummyUserRole: String = "User"
    @State static var dummyUserImageUrl: String = "https://via.placeholder.com/150"
    @State static var dummyIsOrganization: Bool = false
    
    static var previews: some View {
        CurrentUserProfileContentView(userId: $dummyUserId, userEmail: $dummyUserEmail, userFirstName: $dummyUserFirstName, userLastName: $dummyUserLastName, userPhoneNumber: $dummyUserPhoneNumber, userRole: $dummyUserRole, userImageUrl: $dummyUserImageUrl, isOrganization: $dummyIsOrganization)
    }
}
