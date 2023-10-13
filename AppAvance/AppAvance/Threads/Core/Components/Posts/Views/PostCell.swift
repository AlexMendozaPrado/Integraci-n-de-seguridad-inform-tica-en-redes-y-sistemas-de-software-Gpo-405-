//
//  FeedCell.swift
//  Threads
//
//

import SwiftUI

struct PostCell: View {
    var post: Post
    
    var body: some View {
        VStack {
            Color("ColorApp")
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 2)
            
            VStack {
                HStack(alignment: .top, spacing: 12) {
                    NavigationLink(value: post.id) {
                        CircularProfileImageView(logoUrl: post.organization.logoUrl, size: .small)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(post.title)
                                .font(.footnote)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        Text(post.content)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            Color("ColorApp")
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 2)
        }
        .foregroundColor(Color.theme.primaryText)
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: dev.post)
    }
}
