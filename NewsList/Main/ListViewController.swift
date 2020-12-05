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

// MARK: - UI
extension ListViewController {
    enum Section: Int {
        case main
        case listing
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
           
            guard let sectionLayoutKind = Section(rawValue: sectionIndex) else { return nil }
            
            switch sectionLayoutKind {
            case .main: return self.generateMainLayout()
            case .listing: return self.generateListingLayout()
            }
        }
        return layout
    }
    
    func generateMainLayout() -> NSCollectionLayoutSection {
        let mainItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let mainItem = NSCollectionLayoutItem(layoutSize: mainItemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [mainItem])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 5,
                                                        bottom: 5,
                                                        trailing: 5)
        return section
    }
    
    func generateListingLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 5,
                                                        bottom: 5,
                                                        trailing: 2)
        
        return section
    }
    
    
}

//https://www.raywenderlich.com/5436806-modern-collection-views-with-compositional-layouts
