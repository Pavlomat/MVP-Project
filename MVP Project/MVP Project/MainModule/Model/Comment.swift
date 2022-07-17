//
//  Person.swift
//  MVP Project
//
//  Created by Pavlov Matvey on 15.07.2022.
//

import Foundation

struct Comment: Codable {
    var postID, id: Int
    var name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
