//
//  DataItem.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import Foundation

public enum DataItemType: Codable {
    
    // More types can be added here.
    case newsItem(NewsItem)
    case undefined
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let item = try? container.decode(NewsItem.self) {
            self = .newsItem(item)
            return
        }
        self = .undefined
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .newsItem(let item):
            try container.encode(item)
        default:
            break
        }
    }

    var newsItemValue: NewsItem? {
        switch self {
        case .newsItem(let item):
            return item
        default:
            return nil
        }
    }
}

public struct DataItem: Codable {
    public let identifier: String?
    public let type: String
    public let items: [DataItemType]?
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case type
        case items
    }
    
    
}
