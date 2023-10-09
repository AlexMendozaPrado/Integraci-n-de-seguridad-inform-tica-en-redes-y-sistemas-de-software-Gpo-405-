//
//  PreviewProvider.swift
//  Threads
//
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    var thread = Thread(
        ownerUid: NSUUID().uuidString,
        caption: "Here's to the crazy ones. The misfits. The rebels",
        videoDescription: "Description",
        videoURL: "https://www.youtube.com/watch?v=rTqrpOLbhHQ",
        timestamp: Timestamp(),
        likes: 247,
        imageUrl: "lewis-hamilton",
        replyCount: 67,
        user: User(
            fullname: "Lewis Hamilton",
            email: "lewis-hamilton@gmail.com",
            username: "lewis-hamilton",
            profileImageUrl: nil,
            id: NSUUID().uuidString
        )
    )
    
    var post = Post(id: NSUUID().uuidString, organizationId: "test", title: "Test post title", postType: "Test post type", content: "ñalksjdfñlaskjdfñlkasjdfñlkjsadl jsañldk jsaldkfjsahfaskdjf lñksjfl sajdf ñasj fñ jsdlfk jasdkf jñalsdfj ", fileResults: ["test1", "test2"], createdAt: Date.now)
    
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
    
    lazy var activityModel = ActivityModel(
        type: .like,
        senderUid: NSUUID().uuidString,
        timestamp: Timestamp(),
        user: self.user
    )
    
    lazy var reply = ThreadReply(
        threadId: NSUUID().uuidString,
        replyText: "This is a test reply for preview purposes",
        threadReplyOwnerUid: NSUUID().uuidString,
        threadOwnerUid: NSUUID().uuidString,
        timestamp: Timestamp(),
        thread: thread,
        replyUser: user
    )
}
