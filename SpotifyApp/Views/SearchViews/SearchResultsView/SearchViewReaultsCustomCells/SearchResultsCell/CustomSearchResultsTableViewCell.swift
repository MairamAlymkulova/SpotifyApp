//
//  CustomCell.swift
//  SpotifyApp
//
//  Created by A Mairam on 27/12/23.
//

import UIKit
import SDWebImage

class CustomSearchResultsTableViewCell: UITableViewCell{
 
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    var resultType: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.shared.placeHolderGrayColor
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false

        
        return image
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = ColorManager.shared.placeHolderGrayColor
        button.translatesAutoresizingMaskIntoConstraints = false

        
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        contentView.tintColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(resultType)
        contentView.addSubview(image)
        contentView.addSubview(button)
        contentView.heightAnchor.constraint(equalToConstant: 70).isActive = true

       

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 30)
        ])
        

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -5),

        ])
        NSLayoutConstraint.activate([
            resultType.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            resultType.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            resultType.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(result: SearchResults) {
        var titleText: String?
        var resultTypeText: String?
        var owner: String?

        switch result {
        case .album(model: let model):
            owner = model.artists.map { $0.name }.joined(separator: ", ")
            titleText = model.name
            resultTypeText = owner.map { "Album • \($0)" }
            if let urlString = model.images.first?.url, let url = URL(string: urlString) {
                image.sd_setImage(with: url)
            }
            
        case .track(model: let model):
            owner = model.artists.map { $0.name }.joined(separator: ", ")
            titleText = model.name
            resultTypeText = owner.map { "Song • \($0)" }
            if let urlString = model.album?.images.first?.url, let url = URL(string: urlString) {
                image.sd_setImage(with: url)
            }
            
        case .playlist(model: let model):
            owner = model.owner?.displayName
            titleText = model.name
            resultTypeText = owner.map { "Playlist • \($0)" }
            if let urlString = model.images?.first?.url, let url = URL(string: urlString) {
                image.sd_setImage(with: url)
            }
        default:
            break
        }
        guard let titleText = titleText, let resultTypeText = resultTypeText else {
            return
        }

        titleLabel.text = titleText
        resultType.text = resultTypeText
        
    }


}
