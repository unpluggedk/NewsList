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
    public let summary: String
    public let headline: String
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case tease
        case summary
        case headline
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
