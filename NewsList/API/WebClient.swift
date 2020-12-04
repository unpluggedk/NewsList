//
//  WebClient.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import Foundation





public final class WebClient {
    let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
    
    func loadJSON(path: String, params: JSON, completion: @escaping (JSON?, Data?, APIError?) -> ()) -> URLSessionDataTask? {
        
        guard let url = URL(string: path) else {
            completion(nil, nil, .invalidURL)
            return nil
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (dataReceived, urlResponse, error) in
            guard let data = dataReceived, let response = urlResponse, error == nil else {
                completion(nil, dataReceived, .unexpected(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! JSON
                        completion(json, data, nil)
                        return
                    } catch {
                        completion(nil, data, .unexpected(error))
                        return
                    }
                }
                completion(nil, data, .httpCode(httpResponse.statusCode))
                return
            }
            
            completion(nil, data, .unexpected(nil))
        }
        return task
    }
}
