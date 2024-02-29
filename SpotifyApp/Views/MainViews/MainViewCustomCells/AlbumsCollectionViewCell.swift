//
//  AlbumsCollectionViewCell.swift
//  SpotifyApp
//
//  Created by A Mairam on 10/1/24.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {
 
    let cellImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "song_image"))
        img.layer.masksToBounds = true
        return img
    }()
    
    let cellLabel: UILabel = {
        let cl = UILabel()
        cl.font = UIFont(name: ConstantsForUIComponents().fontRegular, size: ConstantsForUIComponents().fontSizeCell)
        cl.numberOfLines = 0
        cl.lineBreakMode = .byWordWrapping
        cl.text = "Me & You"
        cl.textColor = .white
        return cl
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        
        contentView.backgroundColor = ConstantsForUIComponents().darkColor
        contentView.layer.cornerRadius = ConstantsForUIComponents().cornerRadius
        contentView.clipsToBounds = true
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        contentView.addSubview(cellImage)
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImage.widthAnchor.constraint(equalToConstant: ConstantsForUIComponents().imageSongWidth),
            cellImage.heightAnchor.constraint(equalToConstant: ConstantsForUIComponents().imageSongWidth)
        ])
        
        contentView.addSubview(cellLabel)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: cellImage.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 7),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
