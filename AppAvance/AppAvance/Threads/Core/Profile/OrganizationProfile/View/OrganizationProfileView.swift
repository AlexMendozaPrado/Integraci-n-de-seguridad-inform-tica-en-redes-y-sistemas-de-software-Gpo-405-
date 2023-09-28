//
//  OrganizationProfileView.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 26/09/23.
//

import SwiftUI

struct OrganizationProfileView: View {
    @State private var selectedThreadFilter: ProfileThreadFilterViewModel = .threads
    @State private var showEditProfile = false
    @StateObject var viewModel: OrganizationProfileViewModel
    @State private var showUserRelationSheet = false
    @State var starClicked = false
    
    let url = URL(string: "https://www.instagram.com/")!
    
    init(organization: Organization) {
        self._viewModel = StateObject(wrappedValue: OrganizationProfileViewModel(organization: organization))
    }
    
    private var organization: Organization {
        return viewModel.organization
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(organization.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        if let desc = organization.description {
                            Text(desc)
                                .font(.footnote)
                        }
                    }
                    
                    Spacer()
                    
                    OrganizationCircularLogoImageView(logoUrl: organization.logoUrl, size: .medium)
                }
                HStack {
                    //Boton para compartir el perfil
                    ShareLink(item: url, label:
                                {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                            .frame(width: 35, height: 32)
                            .background(.black)
                            .cornerRadius(8)
                    })
                    
                    Button {
                        starClicked.toggle()
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
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
    
     
}

struct OrganizationProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationProfileView(organization: dev.organization)
    }
}
