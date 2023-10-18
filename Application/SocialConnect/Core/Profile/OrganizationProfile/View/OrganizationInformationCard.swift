//
//  OrganizationInformationCard.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 17/10/23.
//

import SwiftUI

struct OrganizationInformationCardView: View {
    var organization: Organization
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Información")
                .font(.title2)
                .bold()
                .padding(.leading)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Address:")
                            .fontWeight(.bold)
                        Text("\(organization.address.street1), \(organization.address.city), \(organization.address.state) \(organization.address.zipCode), \(organization.address.country)")
                    }
                    .padding(.bottom)
                    
                    if let schedule = organization.schedule {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Schedule:")
                                .fontWeight(.bold)
                            Text(schedule)
                        }
                    }
                }

                Spacer()

                VStack(alignment: .leading, spacing: 2) {
                    Text("Contact:")
                        .fontWeight(.bold)
                    Text("Phone: \(organization.contact.phoneNumber)")
                    Text("Email: \(organization.contact.email)")
                }
            }
            .padding(12)
            .background(Color.white.opacity(0.2))
            .cornerRadius(12)
            .shadow(radius: 5)
        }
    }
}

struct OrganizationInformationCardView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationInformationCardView(organization: dev.organization)
    }
}
