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
    
    // MARK: CollectionView properties and enums
    typealias DataSource = UICollectionViewDiffableDataSource<Section, NewsItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, NewsItem>
    
    enum Section: Int {
        case main
        case listing
    }
    
    private lazy var dataSource = setupDataSource()
    private var newsItems: [NewsItem]?
    private var imageCache = ImageCache()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
        
        NewsService().getNewsItem { [weak self] (items, error) in
            guard let self = self else { return }
            guard let newsItems = items, error == nil else {
                // show some error
                return
            }
            
            self.newsItems = newsItems
            self.updateCollectionView()
        }
    }
    

    func setupCollectionView() {
        collectionView.register(UINib(nibName: "NewsItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierListItem)
        collectionView.register(UINib(nibName: "NewsMainItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierMainItem)
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = generateLayout()
    }
    
    func setupDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { [unowned self] (collectionView, indexPath, asset) -> UICollectionViewCell? in
            
            guard let sectionLayoutKind = Section(rawValue: indexPath.section) else { return nil }
            guard let newsItems = self.newsItems else { return nil }
            
            switch sectionLayoutKind {
            case .main:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierMainItem, for: indexPath) as? NewsItemCollectionViewCell else {
                    fatalError("New cell can't be created")
                }
                cell.setNewsItem(newsItems[0], imageCache)
                return cell
             
            case .listing:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierListItem, for: indexPath) as? NewsItemCollectionViewCell else {
                    fatalError("New cell can't be created")
                }
                cell.setNewsItem(newsItems[indexPath.row + 1], imageCache)
                return cell
            }
        }
        return dataSource
    }
}

// MARK: - CollectionView UI
extension ListViewController {

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
                                                        leading: 0,
                                                        bottom: 5,
                                                        trailing: 0)
        return section
    }
    
    func generateListingLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 2,
                                                     bottom: 2,
                                                     trailing: 2)
        
        let itemsPerRow = DeviceInfo.isTablet ? 3 : 2
        
        // heightDimensionFraction: take 1:1 aspect ratio
        let heightDimensionFraction: CGFloat = 1 / 4
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(heightDimensionFraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: itemsPerRow)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func updateCollectionView() {
        guard let newsItems = newsItems else { return }
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, NewsItem>()
        snapShot.appendSections([.main, .listing])
        
        guard let mainItem = newsItems.first else { return }
        snapShot.appendItems([mainItem], toSection: .main)
        
        snapShot.appendItems(Array(newsItems[1...]), toSection: .listing)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot)
        }
    }
}

