//
//  NewsItemCollectionViewCell.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import UIKit

class NewsItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teaseImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
