import SwiftUI
import WebKit

struct PostDetailsView: View {
    @State private var showReplySheet = false
    @StateObject var viewModel: PostDetailsViewModel
    
    private var post: Post {
        return viewModel.post
    }
    
    init(post: Post) {
        self._viewModel = StateObject(wrappedValue: PostDetailsViewModel(post: post))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    CircularProfileImageView(logoUrl: post.organization.logoUrl, size: .small)
                    
                    Text(post.organization.userName ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text("12m")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray3))
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(Color(.darkGray))
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(post.content)
                        .font(.subheadline)
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider()
                .padding(.vertical)
            
            LazyVStack(spacing: 16) {
                ForEach(viewModel.replies) { reply in
                    PostCell(post: viewModel.post)
                }
            }
        }
        .padding()
        .navigationTitle("Post")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailsView(post: dev.post)
    }
}
