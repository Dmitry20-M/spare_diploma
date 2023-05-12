//
//  PostModel.swift
//  Navigation
//
//  Created by iAlesha уличный on 12.05.2023.
//

import UIKit

struct PostModel {
    let author: String
    var description: String
    let image: String
    var likes: Int
    var views: Int
}

extension PostModel {
    static func getArray() -> [PostModel] {
        [
            PostModel(
                author: "Hipster Tom",
                description: "Hi, everyone!",
                image: "teslaOptimus",
                likes: 2,
                views: 2
            ),
            PostModel(
                author: "Hipster Tom",
                description: "My avatar image",
                image: "AR",
                likes: 5,
                views: 5
            ),
          
            PostModel(
                author: "Hipster Tom",
                description: "Love my cat Richard",
                image: "AI",
                likes: 7,
                views: 7
            )
        ]
    }
}

