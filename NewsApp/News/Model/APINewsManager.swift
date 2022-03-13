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
    var url: URL
    var apiKey: String
    
    init() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        
        sessionConfiguration = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfiguration)
        apiKey = "00918c3d3188418eb025b1318a41d30c"
        url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=\(strDate)&sortBy=publishedAt&pageSize=100&apiKey=\(apiKey)")!
    }
    
    func FetchFreshNews(completionHandler: @escaping ((APIResult<News>) -> Void)) {
        let request = URLRequest(url: url)
        FetchNews(request: request, completion: completionHandler)
    }
}
