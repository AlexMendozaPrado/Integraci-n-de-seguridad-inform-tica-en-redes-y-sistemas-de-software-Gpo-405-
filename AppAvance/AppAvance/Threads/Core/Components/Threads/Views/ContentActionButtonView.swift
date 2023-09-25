// Importación necesaria
import SwiftUI

// Vista para mostrar los botones de acción en el contenido (hilos o respuestas)
struct ContentActionButtonView: View {
    @ObservedObject var viewModel: ContentActionButtonViewModel // ViewModel que controla las acciones del contenido
    @State private var showReplySheet = false // Controla la visualización de la hoja de respuesta para un hilo
    
    // Propiedad calculada que verifica si el contenido ha sido marcado como "me gusta"
    private var didLike: Bool {
        return viewModel.thread?.didLike ?? false
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack(spacing: 16) {
                // Botón para marcar o desmarcar como "me gusta"
                Button {
                    handleLikeTapped()
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .foregroundColor(didLike ? .red : Color.theme.primaryText)
                }
                
                // Botón para mostrar la hoja de respuesta
                Button {
                    showReplySheet.toggle()
                } label: {
                    Image(systemName: "bubble.right")
                }
                
                // Otros botones no especificados en el código
                Button {
                    
                } label: {
                    Image(systemName: "arrow.rectanglepath")
                        .resizable()
                        .frame(width: 18, height: 16)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.small)
                }

            }
            .foregroundStyle(Color.theme.primaryText)
            
            // Visualización del número de respuestas y "me gusta" en el contenido
            HStack(spacing: 4) {
                if let thread = viewModel.thread {
                    if thread.replyCount > 0 {
                        Text("\(thread.replyCount) Respuestas")
                    }
                    
                    if thread.replyCount > 0 && thread.likes > 0 {
                        Text("-")
                    }
                    
                    if thread.likes > 0 {
                        Text("\(thread.likes) favoritos")
                    }
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.vertical, 4)
        }
        .sheet(isPresented: $showReplySheet) {
            if let thread = viewModel.thread {
                ThreadReplyView(thread: thread)
            }
        }
    }
    
    // Función para manejar la acción de marcar o desmarcar como "me gusta"
    private func handleLikeTapped() {
        Task {
            if didLike {
                try await viewModel.unlikeThread() // Se desmarca como "me gusta"
            } else {
                try await viewModel.likeThread() // Se marca como "me gusta"
            }
        }
    }
}

// Vista previa de ContentActionButtonView
struct ContentActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ContentActionButtonView(viewModel: ContentActionButtonViewModel(contentType: .thread(dev.thread)))
    }
}
