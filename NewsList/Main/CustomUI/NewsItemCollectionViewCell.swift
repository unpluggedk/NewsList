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

    weak var imageCache: ImageCache?
    
    var dataTask: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setNewsItem(_ newsItem: NewsItem, _ cache: ImageCache? = nil) {
        imageCache = cache
        
        headlineLabel.text = newsItem.headline
        summaryTextLabel.text = newsItem.summary
        
        teaseImageView.image = nil
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let image = cache?.loadImage(url: newsItem.tease) {
                DispatchQueue.main.async {
                    self.teaseImageView.image = image
                }
            } else {
                self.asyncTeaseLoad(newsItem.tease)
            }
        }
    }
    
    private func asyncTeaseLoad(_ url: URL) {
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                print("Error downloading", error ?? "")
                return
            }

            self.dataTask = nil
            let image = UIImage(data: data)!
            self.imageCache?.setImage(image, forURL: url)
            DispatchQueue.main.async {
                self.teaseImageView.image = image
            }
        }
        dataTask?.resume()
    }
}
