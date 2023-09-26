//
//  CircularProfileImageView.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 26/09/23.
//

import SwiftUI
import Kingfisher

enum OrganizationLogoImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 48
        case .large: return 64
        case .xLarge: return 80
        }
    }
}

struct OrganizationCircularLogoImageView: View {
    var organization: Organization?
    let size: OrganizationLogoImageSize
    
    var body: some View {
        if let imageUrl = organization?.logoUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundColor(Color(.systemGray4))
        }
    }
}

struct OrganizationCircularLogoImageView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationCircularLogoImageView(organization: dev.organization, size: .xxSmall)
    }
}
