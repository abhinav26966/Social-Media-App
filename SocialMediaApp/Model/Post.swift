//
//  Post.swift
//  SocialMediaApp
//
//  Created by Abhinav Nagar on 28/08/24.
//

import SwiftUI
import FirebaseFirestore

// Post Model
struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    var text: String
    var imageURL: URL?
    var imageReferenceID: String = ""
    var publishedDate: Date = Date()
    var likedIDs: [String] = []
    var dislikedIDs: [String] = []
    
    var userName: String
    var userUID: String
    var userProfileURL: URL

    enum CodingKeys: CodingKey {
        case id
        case text
        case imageURL
        case imageReferenceID
        case publishedDate
        case likedIDs
        case dislikedIDs
        case userName
        case userUID
        case userProfileURL
    }
}
