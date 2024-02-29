//
//  SearchResultsViewController.swift
//  SpotifyApp
//
//  Created by A Mairam on 27/12/23.
//

import UIKit

class SearchResultsViewController: UIViewController{
    
    weak var delegate: SearchResultsViewControllerDelegate?
    var results: [SearchResults] = []
    let cell = "cellID"
    
    private let tableViewSearchHistory: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = false
        tableView.backgroundColor = .black
        return tableView
    }()

    var rescentSearchesTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .bold)

        label.text = "Recent searches"
        label.translatesAutoresizingMaskIntoConstraints = false

        
        return label
    }()
    override func viewDidLoad(){
        
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(rescentSearchesTitle)
        view.addSubview(tableViewSearchHistory)
        tableViewSearchHistory.dataSource = self
        tableViewSearchHistory.delegate = self
        tableViewSearchHistory.register(CustomSearchResultsTableViewCell.self, forCellReuseIdentifier: cell)
        tableViewSearchHistory.register(CustomArtistsTableViewCell.self, forCellReuseIdentifier: "artistsCell")

        setupConstraints()
    }
    
    
    func update(with results: [SearchResults]){
        self.results = results
        tableViewSearchHistory.reloadData()
        tableViewSearchHistory.isHidden = results.isEmpty
        setupConstraints()
    }

    private func setupConstraints() {
            NSLayoutConstraint.activate([
                rescentSearchesTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                rescentSearchesTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                rescentSearchesTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

                tableViewSearchHistory.topAnchor.constraint(equalTo: rescentSearchesTitle.bottomAnchor, constant: 10),
                tableViewSearchHistory.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableViewSearchHistory.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableViewSearchHistory.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
}
