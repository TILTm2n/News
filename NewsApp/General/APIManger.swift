//
//  APIManger.swift
//  NewsPosts
//
//  Created by Eugene on 06.03.2022.
//

import Foundation

enum APIResult<News> {
    case Success(News)
    case Failure(Error)
}

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith(request: URLRequest, completion: @escaping (News?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask
    func FetchNews<News>(request: URLRequest, completion: @escaping (APIResult<News>) -> Void)
}

//default implementation
extension APIManager {
    
    func JSONTaskWith(request: URLRequest, completion: @escaping (News?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let decoder = JSONDecoder()
        let dataTask = session.dataTask(with: request) { data, response, error in
            //поверка наличия HTTPURLResponse
            guard let HTTPResponse = response as? HTTPURLResponse else {
                completion(nil, nil, error)
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let newsData = try decoder.decode(News.self, from: data!)
                        completion(newsData, HTTPResponse, nil)
                    } catch let error as NSError {
                        completion(nil, HTTPResponse, error)
                    }
                default:
                    print("default")
                }
            }
        }
        return dataTask
    }
    
    func FetchNews<News>(request: URLRequest, completion: @escaping (APIResult<News>) -> Void) {
        let dataTask = JSONTaskWith(request: request) { newsData, response, error in
            //проверка на наличие данных
            guard let newsData = newsData else {
                if let error = error {
                    completion(.Failure(error))
                }
                return
            }
            //проверка на преобразование в тип News
            if let newsData = newsData as? News {
                completion(.Success(newsData))
            }
        }
        dataTask.resume()
    }
    
}
