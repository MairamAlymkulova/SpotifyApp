//
//  PlayListViewController.swift
//  SpotifyApp
//
//  Created by A Mairam on 7/1/24.
//

import UIKit

class PlaylistViewController: UIViewController{
    
    var tracks: [AudioTrack]
    
    private let gradientView = CAGradientLayer()
    
    private var tracksTableView: TracksTableView
    
    private var playlistTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Playlist Title"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var createdByLabel: UILabel = {
        let label = UILabel()
        label.text = "Created by Your Name"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let playlistImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    init(playlist: PlaylistDetails) {
        
        self.tracks = playlist.tracks.items.map { $0.track }
        self.tracksTableView = TracksTableView(tracks: tracks)

        super.init(nibName: nil, bundle: nil)
        
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientView.frame = view.bounds
        view.layer.addSublayer(gradientView)
        tracksTableView.delegate = self
        setupNavigationBar()
            
        setupUI()

    }

    private func setupUI() {
        
        view.addSubview(playlistImage)
        view.addSubview(playlistTitleLabel)
        view.addSubview(createdByLabel)
        view.addSubview(tracksTableView)
        tracksTableView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            playlistImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            playlistImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playlistImage.heightAnchor.constraint(equalToConstant: UIView.screenWidth - 120),
            playlistImage.widthAnchor.constraint(equalToConstant: UIView.screenWidth - 120),

            
            playlistTitleLabel.topAnchor.constraint(equalTo: playlistImage.bottomAnchor, constant: 16),
            playlistTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playlistTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            createdByLabel.topAnchor.constraint(equalTo: playlistTitleLabel.bottomAnchor, constant: 8),
            createdByLabel.leadingAnchor.constraint(equalTo: playlistTitleLabel.leadingAnchor),
            createdByLabel.leadingAnchor.constraint(equalTo: playlistTitleLabel.trailingAnchor),
            
            tracksTableView.topAnchor.constraint(equalTo: createdByLabel.bottomAnchor, constant: 16),
            tracksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tracksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tracksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       
    }
    
    private func setupNavigationBar () {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .white
        backButton.title = ""
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupGradientBackground () {

        if let image = playlistImage.image {
                let imageColor = image.averageColor()
            gradientView.colors = [imageColor.cgColor, ColorManager.shared.grayForPlayerBackground.cgColor]
            } else {
                gradientView.colors = [ColorManager.shared.grayForPlayerBackground.cgColor]
            }
    }
    
    
    func setValues(playList: PlaylistDetails){
        self.createdByLabel.text = playList.owner.displayName
        self.playlistTitleLabel.text = playList.name
        let url = playList.images.first?.url ?? ""
        self.playlistImage.sd_setImage(with: URL(string: url)){ [weak self] (image, error, _, _) in
            if error == nil, let image = image {
                self?.setupGradientBackground()
            }
        }
    }
}

