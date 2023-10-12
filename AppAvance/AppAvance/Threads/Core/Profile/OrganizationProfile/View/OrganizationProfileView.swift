//
//  OrganizationProfileView.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 26/09/23.
//

import SwiftUI
import Kingfisher

struct OrganizationProfileView: View {
    @State private var selectedThreadFilter: ProfileThreadFilterViewModel = .threads
    @State private var showEditProfile = false
    @StateObject var viewModel: OrganizationProfileViewModel
    @State private var showUserRelationSheet = false
    @State var starClicked = false
    @State private var imageLoadSuccess: Bool? = nil
    @State var bannerRetrieved = true

    let url = URL(string: "https://www.instagram.com/")!

    init(organization: Organization) {
        self._viewModel = StateObject(wrappedValue: OrganizationProfileViewModel(organization: organization))
    }

    private var organization: Organization {
        return viewModel.organization
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ZStack {
                        // Background (Banner or Gray Color)
                        AnyView(
                            Group {
                                if organization.bannerUrl.isEmpty || imageLoadSuccess == false {
                                    Color.gray
                                } else {
                                    KFImage(URL(string: organization.bannerUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .onAppear {
                                            KingfisherManager.shared.retrieveImage(with: URL(string: organization.bannerUrl)!) { result in
                                                switch result {
                                                case .success(_):
                                                    imageLoadSuccess = true
                                                case .failure(_):
                                                    imageLoadSuccess = false
                                                }
                                            }
                                        }
                                }
                            }
                        )
                        .edgesIgnoringSafeArea(.all)

                        VStack {
                            Rectangle()
                                .fill(Color.white.opacity(0.8))
                                .edgesIgnoringSafeArea(.all)
                        }

                        // Logo, Title, Description, and Buttons
                        VStack(spacing: 8) {
                            Spacer(minLength: 20) // Space to avoid overlapping with navigation bar

                            HStack {
                                VStack(alignment: .leading) {
                                    Text(organization.name)
                                        .font(.title)
                                        .fontWeight(.semibold)

                                    if let desc = organization.description {
                                        Text(desc)
                                    }
                                }

                                Spacer()

                                OrganizationCircularLogoImageView(logoUrl: organization.logoUrl, size: .large)
                            }

                            Spacer()

                            // Favorite and Share buttons
                            HStack(spacing: 10) {
                                // Sharing button
                                ShareLink(item: url, label: {
                                    Image(systemName: "square.and.arrow.up")
                                        .foregroundColor(.white)
                                        .frame(width: 35, height: 32)
                                        .background(.black)
                                        .cornerRadius(8)
                                })

                                // Favorite star button
                                Button {
                                    starClicked.toggle()
                                    if !starClicked {
                                        viewModel.markAsFavorite(organizationId: organization.id)
                                    } else {
                                        viewModel.unmarkAsFavorite(organizationId: organization.id)
                                    }
                                } label: {
                                    ZStack{
                                        Color.black
                                            .frame(width: 35, height: 32)
                                            .cornerRadius(8)

                                        Image(systemName: starClicked ? "star.fill" : "star")
                                            .foregroundColor(starClicked ? .yellow : .white)
                                            .frame(width: 33, height: 30)
                                            .background(starClicked ? .white : .black)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                        .padding([.leading, .top, .bottom, .trailing])
                    }
                    .frame(height: geometry.size.height / 4)

                    Spacer()

                    VStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Address:")
                                    .fontWeight(.bold)
                                Text("\(organization.address.street1), \(organization.address.city), \(organization.address.state) \(organization.address.zipCode), \(organization.address.country)")
                            }

                            Spacer()

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Contact:")
                                    .fontWeight(.bold)
                                Text("Phone: \(organization.contact.phoneNumber)")
                                Text("Email: \(organization.contact.email)")
                            }
                        }
                        .padding(12)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                        .shadow(radius: 5)

                        // Social Networks
                        HStack(spacing: 10) {
                            ForEach(organization.socialNetworks, id: \.name) { network in
                                Link(destination: URL(string: network.url)!) {
                                    Text(network.name)
                                }
                            }
                        }

                        // Schedule
                        if let schedule = organization.schedule {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Schedule:")
                                    .fontWeight(.bold)
                                Text(schedule)
                            }
                        }

                        Spacer()

                        // Files section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Files:")
                                .fontWeight(.bold)
                        }

                        Spacer()
                    }
                    .padding([.top, .horizontal])
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }

    func getBannerHeight(geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).minY
        let height: CGFloat = geometry.size.height / 4
        let bannerHeight = height - offset / 4  // Adjust this calculation as needed to control the shrinking effect
        return max(bannerHeight, height / 2)    // This ensures banner doesn't get too small
    }
}

struct OrganizationProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationProfileView(organization: dev.organization)
    }
}
