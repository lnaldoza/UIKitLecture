//
//  PostModel.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/31/25.
//

import Foundation

/// https:jsonplaceholder.typicode.com/posts/1

struct PostQuery {
    let id: String
}

struct PostModel: Decodable {
    let id: Int
    let title: String
    let body: String
}
