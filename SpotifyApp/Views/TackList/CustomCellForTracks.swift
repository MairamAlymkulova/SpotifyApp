//
//  CustomCellForTracks.swift
//  SpotifyApp
//
//  Created by A Mairam on 7/1/24.
//

import UIKit

class CustomCellForTracks: UITableViewCell {
    
    var explicit: Bool = false {
        didSet {
            explisciteIcon.isHidden = !explicit
            updateConstraintsForExplicitState()
        }
    }
    
    private let trackTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.shared.placeHolderGrayColor
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moreInfoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var explisciteIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "explicit")
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var artistLabelExplicitTrueConstraint: NSLayoutConstraint!
    private var artistLabelExplicitFalseConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        contentView.addSubview(trackTitleLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(moreInfoButton)
        contentView.addSubview(explisciteIcon)
        
        artistLabelExplicitTrueConstraint = artistNameLabel.leadingAnchor.constraint(equalTo: explisciteIcon.trailingAnchor, constant: 5)
        artistLabelExplicitFalseConstraint = artistNameLabel.leadingAnchor.constraint(equalTo: trackTitleLabel.leadingAnchor)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 80),
            
            moreInfoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            moreInfoButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moreInfoButton.widthAnchor.constraint(equalToConstant: 20),
            
            trackTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            trackTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            trackTitleLabel.trailingAnchor.constraint(equalTo: moreInfoButton.leadingAnchor, constant: -20),
            
            explisciteIcon.topAnchor.constraint(equalTo: trackTitleLabel.bottomAnchor, constant: 10),
            explisciteIcon.leadingAnchor.constraint(equalTo: trackTitleLabel.leadingAnchor),
            explisciteIcon.widthAnchor.constraint(equalToConstant: 16),
            explisciteIcon.heightAnchor.constraint(equalToConstant: 16),
            
            artistNameLabel.centerYAnchor.constraint(equalTo: explisciteIcon.centerYAnchor),
        ])
        
        updateConstraintsForExplicitState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(track: AudioTrack) {
        artistNameLabel.text = track.artists.map { $0.name }.joined(separator: ", ")
        trackTitleLabel.text = track.name
        explicit = track.explicit
    }
    
    private func updateConstraintsForExplicitState() {
        if explicit {
            NSLayoutConstraint.deactivate([artistLabelExplicitFalseConstraint])
            NSLayoutConstraint.activate([artistLabelExplicitTrueConstraint])
        } else {
            NSLayoutConstraint.deactivate([artistLabelExplicitTrueConstraint])
            NSLayoutConstraint.activate([artistLabelExplicitFalseConstraint])
        }
    }
}
