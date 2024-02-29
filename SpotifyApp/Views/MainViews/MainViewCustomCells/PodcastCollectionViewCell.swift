//
//  PodcastCollectionViewCell.swift
//  SpotifyApp
//
//  Created by A Mairam on 10/1/24.
//

import UIKit

class PodcastCollectionViewCell: UICollectionViewCell {
 
    let cellImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "podcast_image"))
        img.layer.cornerRadius = ConstantsForUIComponents().cornerRadius
        img.layer.masksToBounds = true
        return img
    }()
    
    let cellMainLabel: UILabel = {
        let cl = UILabel()
        cl.font = UIFont(name: ConstantsForUIComponents().fontBold, size: ConstantsForUIComponents().fontSizeCell)
        cl.numberOfLines = 2
        cl.lineBreakMode = .byWordWrapping
        cl.text = "Things You Thought You Knew - What Is Exit Velocity?"
        cl.textColor = .white
        return cl
    }()
    
    let cellSecondLabel: UILabel = {
        let cl = UILabel()
        cl.font = UIFont(name: ConstantsForUIComponents().fontBold, size: ConstantsForUIComponents().fontSizeCell)
        cl.numberOfLines = 2
        cl.lineBreakMode = .byTruncatingTail
        cl.text = "What is exit velocity? On this episode, Neil deGrasse Tyson and co-hosts Chuck Nice and Gary O’Reilly explore parabolas, measuring the speed of an object using the Doppler effect, and other physics in baseball."
        cl.textColor = .lightGray
        return cl
    }()
    
    let buttonAdd: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "add_image"), for: .normal)
        return btn
    }()
    
    let cellInfoLabel: UILabel = {
        let cl = UILabel()
        cl.font = UIFont(name: ConstantsForUIComponents().fontBold, size: ConstantsForUIComponents().fontSizeCell)
        cl.numberOfLines = 2
        cl.lineBreakMode = .byWordWrapping
        cl.text = "Fri" + " ~ " + "53min"
        cl.textColor = .lightGray
        return cl
    }()
    
    let buttonPlay: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "play_image"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.backgroundColor = .black

        contentView.addSubview(cellImage)
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImage.widthAnchor.constraint(equalToConstant: ConstantsForUIComponents().imagePodcastWidth),
            cellImage.heightAnchor.constraint(equalToConstant: ConstantsForUIComponents().imagePodcastWidth)
        ])

        contentView.addSubview(cellMainLabel)
        cellMainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellMainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellMainLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 7),
            cellMainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            cellMainLabel.heightAnchor.constraint(equalToConstant: ConstantsForUIComponents().imagePodcastWidth / 3)
        ])
        
        contentView.addSubview(cellSecondLabel)
        cellSecondLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellSecondLabel.topAnchor.constraint(equalTo: cellMainLabel.bottomAnchor),
            cellSecondLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 7),
            cellSecondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            cellSecondLabel.heightAnchor.constraint(equalToConstant: ConstantsForUIComponents().imagePodcastWidth / 3)
        ])
        
        contentView.addSubview(buttonAdd)
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonAdd.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            buttonAdd.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 7)
        ])
        
        contentView.addSubview(cellInfoLabel)
        cellInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellInfoLabel.leadingAnchor.constraint(equalTo: buttonAdd.trailingAnchor, constant: 5)
        ])
        
        contentView.addSubview(buttonPlay)
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonPlay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            buttonPlay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            buttonPlay.widthAnchor.constraint(equalToConstant: 24),
            buttonPlay.heightAnchor.constraint(equalToConstant: 24)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
