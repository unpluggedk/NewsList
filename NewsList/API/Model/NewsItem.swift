//
//  NewsItem.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import Foundation

public struct NewsItem: Codable, Hashable {
    
    public let identifier: UUID = UUID()
    
    public let tease: URL
    public let summary: String
    public let headline: String
    
    public enum CodingKeys: String, CodingKey {
        case tease
        case summary
        case headline
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
}
