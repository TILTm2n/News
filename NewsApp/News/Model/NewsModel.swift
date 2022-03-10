//
//  NewsModel.swift
//  NewsPosts
//
//  Created by Eugene on 06.03.2022.
//

import Foundation

struct News: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles
    }
}

struct Article: Codable {
    var source: Source
    var author: String?
    var title: String?
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

struct Source: Codable {
    var id: String?
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

