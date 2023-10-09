//
//  FeedCell.swift
//  Threads
//
//

import SwiftUI

enum PostViewConfig {
    case post(Post)
}

struct PostCell: View {
    let config: PostViewConfig
    @State private var showPostActionSheet = false
    @State private var selectedPostAction: PostActionSheetOptions?
    
    var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }
    
    private var user: String? {
        switch config {
        case .post(let post):
            return post.organizationId
        }
    }
        
    var caption: String {
        switch config {
        case .post(let post):
            return post.content
        }
    }
    
    var timestampString: Date {
        switch config {
        case .post(let post):
            return post.createdAt
        }
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                NavigationLink(value: user) {
                    OrganizationCircularLogoImageView(logoUrl: user, size: .small)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(user ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("\(dateFormat.string(from: timestampString))")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                        
                        Button {
                            showPostActionSheet.toggle()
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    
                    Text(caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }
            }
            .sheet(isPresented: $showPostActionSheet) {
                if case .post(let post) = config {
                    PostActionSheetView(post: post, selectedAction: $selectedPostAction)
                }
            }
            
            Divider()
        }
        .foregroundColor(Color.theme.primaryText)
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(config: .post(dev.post))
    }
}
