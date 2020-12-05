//
//  NewsItemCollectionViewCell.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import UIKit

class NewsItemCollectionViewCell: UICollectionViewCell, NewsItemSettable {

    @IBOutlet weak var teaseImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setNewsItem(_ newsItem: NewsItem) {
        headlineLabel.text = newsItem.headline
        summaryTextLabel.text = newsItem.summary
    }
}
