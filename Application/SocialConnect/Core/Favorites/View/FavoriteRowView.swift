import SwiftUI

struct ActivityRowView: View {
    let favorite: Favorite

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                NavigationLink(value: favorite.favoriteId) {
                    ZStack(alignment: .bottomTrailing) {
                        OrganizationCircularLogoImageView(logoUrl: favorite.logoUrl, size: .large)
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        VStack {
                            Text(favorite.name)
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.theme.primaryText)

                            Text(favorite.description ?? "No description for this organization")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}

struct ActivityRowView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRowView(favorite: dev.favorite)
    }
}
