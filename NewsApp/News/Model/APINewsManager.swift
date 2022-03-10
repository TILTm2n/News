//
//  APINewsManager.swift
//  NewsPosts
//
//  Created by Eugene on 06.03.2022.
//

import Foundation

final class APINewsManager: APIManager {
    var sessionConfiguration: URLSessionConfiguration
    var session: URLSession
    var url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2022-02-09&sortBy=publishedAt&apiKey=00918c3d3188418eb025b1318a41d30c")
    
    init() {
        sessionConfiguration = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfiguration)
    }
    
    func FetchFreshNews(completionHandler: @escaping ((APIResult<News>) -> Void)) {
        let request = URLRequest(url: url!)
        FetchNews(request: request, completion: completionHandler)
    }
}
