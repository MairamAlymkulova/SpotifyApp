//
//  CustomArtistsTableViewCell.swift
//  SpotifyApp
//
//  Created by A Mairam on 6/1/24.
//

import UIKit

class CustomArtistsTableViewCell: UITableViewCell {
    
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
           image.contentMode = .scaleAspectFit
           image.image = UIImage(systemName: "music.note")
           image.backgroundColor = ColorManager.shared.grayForPlayerBackground
           image.tintColor = .white
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

           image.layer.cornerRadius = 25
        
           image.layer.masksToBounds = true

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
       
    func setValues(result: Artist) {
        var titleText: String?
        var resultTypeText: String?
        
        titleText = result.name
        resultTypeText = "Artist"
        if let urlString = result.images?.first?.url, let url = URL(string: urlString) {
            image.sd_setImage(with: url)
        }
        
        
        
        guard let titleText = titleText, let resultTypeText = resultTypeText else {
            return
        }
        
        titleLabel.text = titleText
        resultType.text = resultTypeText
        
    }


   }

