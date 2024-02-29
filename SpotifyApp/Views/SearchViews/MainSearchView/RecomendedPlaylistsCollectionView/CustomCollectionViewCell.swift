//
//  CustomCollectionViewCell.swift
//  SpotifyApp
//
//  Created by A Mairam on 27/12/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    private let playListImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "ImagineDragons")
        imageView.layer.cornerRadius = 30
        imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)

        
        return imageView
    }()
    
    
    private let playListTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(playListTitleLabel)
        contentView.addSubview(playListImage)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playListTitleLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playListTitleLabel.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width/2, height: contentView.bounds.height/2)
        playListImage.frame = CGRect(x: contentView.bounds.width - 40, y: contentView.bounds.height / 3, width: contentView.bounds.height - 40, height: contentView.bounds.height - 40)

        
    }
    
    func configure(category: CategoryItem){
        self.playListTitleLabel.text = category.name
        let url = category.icons.first?.url ?? ""
        self.playListImage.sd_setImage(with: URL(string: url))
        
        contentView.backgroundColor = UIColor.random()
    }
}
