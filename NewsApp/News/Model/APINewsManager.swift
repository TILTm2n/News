//
//  APINewsManager.swift
//  NewsPosts
//
//  Created by Eugene on 06.03.2022.
//

import Foundation

final class APINewsManager: APIManager {
    
    let apiKey = "00918c3d3188418eb025b1318a41d30c"
    
    var url: URL
    var sessionConfiguration: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    
    init(page: Int) {
        let date = Date()
        let dateFormatter = DateFormatter()
        let strDate = dateFormatter.string(from: date)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        sessionConfiguration = URLSessionConfiguration.default
        url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=\(strDate)&sortBy=publishedAt&pageSize=20&page=\(page)&apiKey=\(apiKey)")!
    }
    
    func FetchFreshNews(completionHandler: @escaping ((APIResult<News>) -> Void)) {
        let request = URLRequest(url: url)
        FetchNews(request: request, completion: completionHandler)
    }
    
}
