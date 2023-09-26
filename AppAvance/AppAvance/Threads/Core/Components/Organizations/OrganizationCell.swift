//
//  OrganizationCell.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 26/09/23.
//

import SwiftUI

struct OrganizationCell: View {
    let organization: Organization
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                OrganizationCircularLogoImageView(logoUrl: organization.logoUrl, size: .small)
                
                VStack(alignment: .leading) {
                    Text(organization.name)
                        .bold()
                }
                .font(.footnote)
                
                Spacer()
                
                

            }
            .padding(.horizontal)
            
            Divider()
        }
        .padding(.vertical, 4)
        .foregroundColor(Color.theme.primaryText)
    }
}

struct OrganizationCell_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationCell(organization: dev.organization)
    }
}
