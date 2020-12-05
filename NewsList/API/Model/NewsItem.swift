//
//  NewsItem.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import Foundation

public struct NewsItem: Codable, Hashable {
    public let identifier: String
    public let tease: URL
    public let label: String
    public let headline: String
    
    public enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case tease
        case label
        case headline
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    public static func == (lhs: NewsItem, rhs: NewsItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
