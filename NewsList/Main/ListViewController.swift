//
//  ListViewController.swift
//  NewsList
//
//  Created by Jason Kim on 12/3/20.
//

import UIKit

private let reuseIdentifierListItem = "listItemCell"
private let reuseIdentifierMainItem = "listMainCell"

class ListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func setupCollectionView() {
        collectionView.register(UINib(nibName: "NewsItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierListItem)
        collectionView.register(UINib(nibName: "NewsMainItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierMainItem)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


