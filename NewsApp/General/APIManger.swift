//
//  APIManger.swift
//  NewsPosts
//
//  Created by Eugene on 06.03.2022.
//

import Foundation

enum APIResult<News> {
    case success(News)
    case failure(Error)
}

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith(request: URLRequest, completion: @escaping (News?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask
    func FetchNews<News>(request: URLRequest, completion: @escaping (APIResult<News>) -> Void)
}

extension APIManager {
    
    func JSONTaskWith(request: URLRequest, completion: @escaping (News?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let decoder = JSONDecoder()
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let HTTPResponse = response as? HTTPURLResponse, let data = data else {
                completion(nil, nil, error)
                return
            }
            
            switch HTTPResponse.statusCode {
            case 200:
                do {
                    let newsData = try decoder.decode(News.self, from: data)
                    completion(newsData, HTTPResponse, nil)
                } catch let error as NSError {
                    completion(nil, HTTPResponse, error)
                }
            default:
                print("default")
            }
        }
        return dataTask
    }
    
    func FetchNews<News>(request: URLRequest, completion: @escaping (APIResult<News>) -> Void) {
        let dataTask = JSONTaskWith(request: request) { newsData, response, error in
            guard let newsData = newsData else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            if let newsData = newsData as? News {
                completion(.success(newsData))
            }
        }
        dataTask.resume()
    }
    
}
