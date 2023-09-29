// ActivityRowView.swift
// Threads
//
//

import SwiftUI

struct ActivityRowView: View {
    let model: Organization

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                NavigationLink(value: model.id) {
                    ZStack(alignment: .bottomTrailing) {
                        OrganizationCircularLogoImageView(logoUrl: model.logoUrl, size: .large)
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Spacer()
                        VStack {
                            Text(model.name)
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.theme.primaryText)
                            
                            Text(model.description ?? "No description for this organization")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button {
                            print("test")
                        } label: {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)

            Divider()
        }
    }
}

struct ActivityRowView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRowView(model: dev.organization)
    }
}
