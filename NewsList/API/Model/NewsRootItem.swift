//
//  NewsRootItem.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import Foundation

public struct NewsRootItem: Codable {
    public let dataItems: [DataItem]
    
    private enum CodingKeys: String, CodingKey {
        case dataItems = "data"
    }
}
