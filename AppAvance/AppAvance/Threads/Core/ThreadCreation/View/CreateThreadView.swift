//
//  CreateThreadView.swift
//  Threads
//
//

import SwiftUI

struct CreateThreadView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = CreateThreadViewModel()
    @Binding var tabIndex: Int
    @State private var videoURL: String = ""
    @State private var imageURL: String = ""
    @State private var description: String = ""
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImageView(user: user, size: .small)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user?.username ?? "")
                            .fontWeight(.semibold)
                        
                        TextField("Inicia a Publicar...", text: $viewModel.caption, axis: .vertical)
                        
                        TextField("URL del video de YouTube", text: $videoURL)
                            .font(.footnote)
                        
                        if !videoURL.isEmpty {
                            WebView(urlString: videoURL)
                                .frame(height: 200) // Set the height as needed
                        }
                        
                        TextField("Descripción", text: $description)
                            .font(.footnote)
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    if !viewModel.caption.isEmpty {
                        Button {
                            viewModel.caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.primaryText)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            try await viewModel.uploadThread()
                            dismiss()
                        }
                    } label: {
                        Label("Publicar", systemImage: "paperplane.fill")
                    }
                    .opacity(viewModel.caption.isEmpty ? 0.5 : 1.0)
                    .disabled(viewModel.caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.primaryText)
                }
            }
            .onDisappear { tabIndex = 0 }
            .navigationTitle("Nueva publicacion")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct CreateThreadView_Previews: PreviewProvider {
    static var previews: some View {
        CreateThreadView(tabIndex: .constant(0))
    }
}
