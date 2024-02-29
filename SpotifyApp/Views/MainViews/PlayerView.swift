//
//  PlayerView.swift
//  SpotifyApp
//
//  Created by A Mairam on 10/1/24.
//

import Foundation

import UIKit

class PlayerView: UIView {

    let songImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "song_image"))
        return img
    }()
    
    let songLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Introverted"
        lbl.textColor = .white
        lbl.font = UIFont(name: ConstantsForUIComponents().fontRegular, size: ConstantsForUIComponents().fontSizeCell)
        return lbl
    }()
    
    let albumLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Elzhi"
        lbl.textColor = .lightGray
        lbl.font = UIFont(name: ConstantsForUIComponents().fontRegular, size: ConstantsForUIComponents().fontSizeCell)
        return lbl
    }()

    let progressView: UIProgressView = {
            let pv = UIProgressView()
            pv.progressTintColor = UIColor.white // Цвет полосы прогресса
            pv.trackTintColor = UIColor.darkGray // Цвет фона полосы прогресса
            return pv
    }()
    
    let deviceButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "device_image"), for: .normal)
        return btn
    }()
    
    let playButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "white_play_image"), for: .normal)
        btn.isSelected = false
        btn.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            initUI()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        
        backgroundColor = ConstantsForUIComponents().darkColor
        
        addSubview(songImage)
        songImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            songImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ConstantsForUIComponents().playerMarging),
            songImage.widthAnchor.constraint(equalToConstant: ConstantsForUIComponents().playerSongImageWidth),
            songImage.heightAnchor.constraint(equalToConstant: ConstantsForUIComponents().playerSongImageWidth)
        ])
        
        addSubview(songLabel)
        songLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            songLabel.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: ConstantsForUIComponents().playerMarging + 2)
        ])
        
        addSubview(albumLabel)
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 8),
            albumLabel.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: ConstantsForUIComponents().playerMarging + 2)
        ])
        
        addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ConstantsForUIComponents().playerMarging - 5)
        ])
        
        addSubview(deviceButton)
        deviceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deviceButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deviceButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -ConstantsForUIComponents().playerMarging - 5)
        ])
        
        progressView.progress = 0.3
        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.heightAnchor.constraint(equalToConstant: ConstantsForUIComponents().progressBarHeight),
            progressView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - ConstantsForUIComponents().marging * 2)
        ])
    }
    
    @objc func playPauseButtonTapped() {
        playButton.isSelected = !playButton.isSelected
        if playButton.isSelected {
            playButton.setImage(UIImage(named: "white_pause_image"), for: .normal)
        } else {
            playButton.setImage(UIImage(named: "white_play_image"), for: .normal)
        }
    }
}
