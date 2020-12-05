//
//  NewsService.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import Foundation
private let newsFeedAPI = "https://s3.amazonaws.com/shrekendpoint/news.json"

public class NewsService {
    public func getNewsItem(completion: @escaping ([NewsItem]?, APIError?) -> ()) {
        WebClient().loadJSON(path: newsFeedAPI, params: [:]) { (json, data, error) in
            guard let _ = json, let data = data, error == nil else {
                completion(nil, .unexpected(error))
                return
            }
            
            do {
                let rootItem = try JSONDecoder().decode(NewsRootItem.self, from: data)
                var newsItems: [NewsItem] = []
                
                for dataItem in rootItem.dataItems {
                    if dataItem.type != "Section" { continue }
                    
                    if let items = dataItem.items {
                        
                        for item in items {
                            if let newsItem = item.newsItemValue, !newsItems.contains(newsItem) {
                                newsItems.append(newsItem)
                            }
                        }
                    }
                }
                
                completion(newsItems, nil)
            } catch {
                print(error)
            }
        }?.resume()
    }
}
