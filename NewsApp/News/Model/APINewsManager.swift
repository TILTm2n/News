//
//  APINewsManager.swift
//  NewsPosts
//
//  Created by Eugene on 06.03.2022.
//

import Foundation

final class APINewsManager: APIManager {
    var sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    var url: URL
    
    init(key: String, page: Int) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        
        sessionConfiguration = URLSessionConfiguration.default
        url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=\(strDate)&sortBy=publishedAt&pageSize=20&page=\(page)&apiKey=\(key)")!
    }
    
    func FetchFreshNews(completionHandler: @escaping ((APIResult<News>) -> Void)) {
        let request = URLRequest(url: url)
        FetchNews(request: request, completion: completionHandler)
    }
}
