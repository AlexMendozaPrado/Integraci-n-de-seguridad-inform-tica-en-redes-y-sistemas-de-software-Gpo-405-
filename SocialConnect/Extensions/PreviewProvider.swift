import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    var post = Post(
        id: NSUUID().uuidString,
        organization: Organization(
            id: NSUUID().uuidString,
            userId: "6511244a9559b458b7518a51",
            name: "test name",
            userName: "test userName",
            rfc: "ASDF8245QFH",
            schedule: "9am-5pm",
            address: Organization.Address(
                street1: "test",
                street2: "test",
                city: "test",
                state: "test",
                zipCode: "test",
                country: "mexico"
            ),
            contact: Organization.Contact(
                phoneNumber: "test",
                email: "test"
            ),
            description: "test",
            socialNetworks: [Organization.SocialNetwork(name: "Facebook", url: "www.facebook.com")],
            logoUrl: "https://gmvykon.com/wp-content/uploads/2021/05/Frisa-logo-400x400-1.jpg",
            videoUrl: "https://www.youtube.com/watch?v=SoJ-L9peEIQ",
            bannerUrl: "https://drive.google.com/uc?export=view&id=1wC7mtwNGiWVO24ciX3DQmI0lTS6QZiPn",
            tags: ["6510b9fb078006769df6cb0c"],
            createdAt: Date.now,
            updatedAt: Date.now
        ),
        title: "Test post title",
        postType: "Test post type",
        content: "ñalksjdfñlaskjdfñlkasjdfñlkjsadl jsañldk jsaldkfjsahfaskdjf lñksjfl sajdf ñasj fñ jsdlfk jasdkf jñalsdfj ",
        filesUrls: ["test1", "test2"],
        createdAt: Date.now
    )
    
    var user = User(
        fullname: "Daniel Ricciardo",
        email: "daniel@gmail.com",
        username: "daniel-ricciardo",
        profileImageUrl: nil,
        id: NSUUID().uuidString
    )
    
    var organization = Organization(
        id: "6511244b9559b458b7518a53",
        userId: "test2",
        name: "Frisa",
        userName: "Frisa",
        rfc: "ASDFKASD72752H",
        schedule: "9am-5pm",
        address: Organization.Address(
            street1: "street1",
            street2: "street2",
            city: "city",
            state: "state",
            zipCode: "zipCode",
            country: "country"
        ),
        contact: Organization.Contact(
            phoneNumber: "phone",
            email: "email"
        ),
        description: "desc",
        socialNetworks: [Organization.SocialNetwork(
            name: "instagram",
            url: "www.instagram.com"
        )],
        logoUrl: "https://static.guiaongs.org/wp-content/uploads/2015/09/so%C3%B1ar-despierto-360x336.jpg",
        videoUrl: "https://www.youtube.com/watch?v=SoJ-L9peEIQ",
        bannerUrl: "https://drive.google.com/uc?export=view&id=1wC7mtwNGiWVO24ciX3DQmI0lTS6QZiPn",
        tags: ["6510b9fb078006769df6cb0c"],
        createdAt: Date(),
        updatedAt: Date()
    )
    
    var favorite = Favorite(
        favoriteId: NSUUID().uuidString,
        id: NSUUID().uuidString,
        userId: "test2",
        name: "Frisa",
        address: Favorite.Address(
            street1: "street1",
            street2: "street2",
            city: "city",
            state: "state",
            zipCode: "zipCode",
            country: "country"
        ),
        contact: Favorite.Contact(
            phoneNumber: "phone",
            email: "email"
        ),
        description: "desc",
        socialNetworks: [Favorite.SocialNetwork(
            name: "instagram",
            url: "www.instagram.com"
        )],
        logoUrl: "https://static.guiaongs.org/wp-content/uploads/2015/09/so%C3%B1ar-despierto-360x336.jpg",
        tags: ["6510b9fb078006769df6cb0c"],
        createdAt: Date(),
        updatedAt: Date()
    )
    
    var tag = Tag(id: NSUUID().uuidString, name: "Autismo", description: "Discapacidad", createdAt: Date(), updatedAt: Date(), updatedBy: "You")
}
