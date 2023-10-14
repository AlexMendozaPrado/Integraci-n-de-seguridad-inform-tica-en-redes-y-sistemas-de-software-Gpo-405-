import SwiftUI

enum CurrentUserProfileSheetConfig: Identifiable {
    case editProfile
    
    var id: Int { return hashValue }
}

struct CurrentUserProfileContentView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel() 
    @State private var sheetConfig: CurrentUserProfileSheetConfig?
    
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
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(Color.theme.primaryText)
                }
            }
            .padding(.bottom)
            
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
                    Button {
                        sheetConfig = .editProfile
                    } label: {
                        Text("Modificar perfil")
                            .foregroundStyle(Color.theme.primaryText)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 175, height: 32)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Compartir Perfil")
                            .foregroundStyle(Color.theme.primaryText)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 175, height: 32)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                }
                
                if let user = user {
                    UserContentListView(viewModel: UserContentListViewModel(user: user))
                }
            }
        }
        .sheet(item: $sheetConfig, content: { config in
            switch config {
            case .editProfile:
                EditProfileView()
                    .environmentObject(viewModel)
            }
        })
    }
}

struct CurrentUserProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileContentView()
    }
}
