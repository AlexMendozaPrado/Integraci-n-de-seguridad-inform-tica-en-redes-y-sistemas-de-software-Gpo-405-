import SwiftUI

struct PostCell: View {
    var post: Post
    
    var body: some View {
        VStack {
            Color("PrimaryText")
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 2)
            
            VStack {
                HStack(alignment: .top, spacing: 12) {
                    NavigationLink(value: post.id) {
                        CircularProfileImageView(logoUrl: post.organization.logoUrl, size: .small)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(post.title)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Text(post.content)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                        
                        // Example: Displaying video URL
                        if !post.videoUrl.isEmpty {
                            WebView(urlString: post.videoUrl)
                                .frame(height: 200)
                        }
                        
                        // Example: Displaying creation date
                        Text("Creado en \(post.createdAt, formatter: DateFormatter.shortDate)")
                            .font(.footnote)
                            .opacity(0.6)
                    }
                }
            }
        }
        .foregroundColor(Color.theme.primaryText)
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: dev.post)
    }
}
