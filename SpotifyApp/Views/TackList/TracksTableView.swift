//
//  TracksTableView.swift
//  SpotifyApp
//
//  Created by A Mairam on 7/1/24.
//

import UIKit

class TracksTableView: UIView {
    
    let tracks: [AudioTrack]
    weak var delegate: TrackTableViewDelegate?

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black.withAlphaComponent(0.7)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    
    init(tracks: [AudioTrack]) {
            
        self.tracks = tracks

        super.init(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CustomCellForTracks.self, forCellReuseIdentifier: "tracksCell")
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
