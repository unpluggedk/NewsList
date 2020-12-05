//
//  NewsMainItemCollectionViewCell.swift
//  NewsList
//
//  Created by Jason Kim on 12/4/20.
//

import UIKit

class NewsMainItemCollectionViewCell: UICollectionViewCell, NewsItemSettable {

    @IBOutlet weak var teaseImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryTextLabel: UILabel!
    
    var newsItemIdentifier: String?
    var dataTask: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setNewsItem(_ newsItem: NewsItem) {
        headlineLabel.text = newsItem.headline
        summaryTextLabel.text = newsItem.summary
        
    }
}
