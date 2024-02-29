//
//  ViewController.swift
//  SpotifyApp
//
//  Created by A Mairam on 27/12/23.
//
import UIKit

class SearchViewController: UIViewController {
    var categories: [CategoryItem]?
    
    let searchController: UISearchController = {
        
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.searchBarStyle = .minimal
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ColorManager.shared.placeHolderGrayColor,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        
        let attributedPlaceholder = NSAttributedString(string: "What do you want to listen to?", attributes: placeholderAttributes)
        vc.searchBar.searchTextField.attributedPlaceholder = attributedPlaceholder
        vc.definesPresentationContext = true
        return vc
    }()
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2,
                leading: 7,
                bottom: 2,
                trailing: 7
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(120)),
                subitem: item,
                count: 2
            )
            group.contentInsets = NSDirectionalEdgeInsets(
                top: 10,
                leading: 0,
                bottom: 10,
                trailing: 0
            )
            
            return NSCollectionLayoutSection(group: group)
        }))
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        APIManager.shared.getData(for: CategoryResponse.self, url: APIUrlConstants.categoryUrl) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.categories = model.categories.items
                    self.collectionView.reloadData()

                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

        view.backgroundColor = ColorManager.shared.darkGrayBackgroundColor
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
  
        searchBarUIconfiguration()
        configureCollectionView()
    }

    private func configureSearchController() {
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            navigationItem.searchController = searchController
            definesPresentationContext = true
        }

        private func configureCollectionView() {
            
            view.addSubview(collectionView)
            
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)

            collectionView.backgroundColor = .black
           
            
        }
    private func searchBarUIconfiguration() {
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.textColor = .white
        searchController.tabBarItem.badgeColor = .white
    }

    @objc private func backButtonPressed() {
    }
}
