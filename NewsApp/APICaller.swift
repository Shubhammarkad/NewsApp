//
//  APICaller.swift
//  NewsApp
//
//  Created by Mac on 20/11/23.
//

import Foundation
final class APICaller{
    static let shared = APICaller()
    struct Constants{
    static let topHeadlineURL = URL(string: "https://newsapi.org/v2/everything?q=apple&from=2023-11-19&to=2023-11-19&sortBy=popularity&apiKey=bc6ab21c308344609d8230c7dcc909ab")
        static let searchingUrlString = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=bc6ab21c308344609d8230c7dcc909ab"
    }
    private init(){}
    public func getTopStories(completion:@escaping(Result<[Article],Error>)->Void){
        guard let url = Constants.topHeadlineURL else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){data,_,error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles:\(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
// models
struct APIResponse : Codable{
    let articles:[Article]
}
struct Article: Codable {
    let source : Source
    let title : String
    let description : String?
    let url : String?
    let urlToImage : String?
    let publishedAt : String
    
}
struct Source: Codable{
    let name : String
    
}
