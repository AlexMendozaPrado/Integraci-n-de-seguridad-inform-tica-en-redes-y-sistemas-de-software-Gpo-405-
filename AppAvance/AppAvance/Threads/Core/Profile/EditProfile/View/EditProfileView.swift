//
//  EditProfileView.swift
//  Threads
//
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @State private var isPrivateProfile = false
    @EnvironmentObject var viewModel: CurrentUserProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    private var user: User? {
        return viewModel.currentUser
    }
        
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                VStack(alignment: .leading){
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Nombre")
                                .fontWeight(.semibold)
                            
                            Text(user?.fullname ?? "")
                        }
                        .font(.footnote)

                        Spacer()
                        
                        PhotosPicker(selection: $viewModel.selectedImage) {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: ProfileImageSize.small.dimension, height: ProfileImageSize.small.dimension)
                                    .clipShape(Circle())
                                    .foregroundColor(Color(.systemGray4))
                            } else {
                                CircularProfileImageView(user: user, size: .small)
                            }
                        }
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Intereses ")
                            .fontWeight(.semibold)
                        
                        TextField("Escribe tus intereses..", text: $viewModel.bio, axis: .vertical)
                    }
                    .font(.footnote)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Informacion de contacto")
                            .fontWeight(.semibold)
                        
                        TextField("Agregar info de contacto...", text: $viewModel.link)
                    }
                    .font(.footnote)
                    
                    Divider()
                    
                    
                }
                
                .navigationTitle("Editar Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancelar") {
                            dismiss()
                        }
                        .font(.subheadline)
                        .foregroundColor(Color.theme.primaryText)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Listo") {
                            Task {
                                try await viewModel.updateUserData()
                                dismiss()
                            }
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                .background(Color.theme.primaryBackground)

                .padding()
            }
            .onAppear {
                viewModel.loadUserData()
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
