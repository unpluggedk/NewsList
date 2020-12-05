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
    
    var newsItemIdentifier: String?
    var dataTask: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setNewsItem(_ newsItem: NewsItem) {
        newsItemIdentifier = newsItem.identifier
        headlineLabel.text = newsItem.headline
        summaryTextLabel.text = newsItem.summary
        
        teaseImageView.image = nil
        asyncTeaseLoad(newsItem.tease)
    }
    
    private func asyncTeaseLoad(_ url: URL) {
        teaseImageView.image = nil
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                print("Error downloading", error ?? "")
                return
            }

            self.dataTask = nil
            let image = UIImage(data: data)!
            
            DispatchQueue.main.async {
                self.teaseImageView.image = image
            }
        }
        dataTask?.resume()
    }
}
