//
//  AlbomViewController.swift
//  SpotifyApp
//
//  Created by A Mairam on 7/1/24.
//

import UIKit


class AlbumViewController: UIViewController{
    
    var tracks: [AudioTrack]
    
    private let gradientView = CAGradientLayer()
    
    private var tableView: TracksTableView
    
    private var albumTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Album Title"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var artistName: UILabel = {
        let label = UILabel()
        label.text = "Created by Name"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let artistImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    init(tracks: [AudioTrack]) {
        
        self.tracks = tracks
        self.tableView = TracksTableView(tracks: tracks)

        super.init(nibName: nil, bundle: nil)
        
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientView.frame = view.bounds
        view.layer.addSublayer(gradientView)
        tableView.delegate = self
        setupNavigationBar()
            
        setupUI()

    }

    private func setupUI() {
        
        view.addSubview(image)
        view.addSubview(albumTitleLabel)
        view.addSubview(artistName)
        view.addSubview(tableView)
        view.addSubview(artistImage)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: UIView.screenWidth - 120),
            image.widthAnchor.constraint(equalToConstant: UIView.screenWidth - 120),

            
            albumTitleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            albumTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            albumTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            artistImage.topAnchor.constraint(equalTo: albumTitleLabel.bottomAnchor, constant: 8),
            artistImage.leadingAnchor.constraint(equalTo: albumTitleLabel.leadingAnchor),
            artistImage.widthAnchor.constraint(equalToConstant: 20),
            artistImage.heightAnchor.constraint(equalToConstant: 20),
            
            artistName.centerYAnchor.constraint(equalTo: artistImage.centerYAnchor),
            artistName.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 5),
            artistName.trailingAnchor.constraint(equalTo: albumTitleLabel.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

        if let image = image.image {
                let imageColor = image.averageColor()
            gradientView.colors = [imageColor.cgColor, ColorManager.shared.grayForPlayerBackground.cgColor]
            } else {
                gradientView.colors = [ColorManager.shared.grayForPlayerBackground.cgColor]
            }
    }
    
    
    func setValues(album: AlbumDetails){
        self.artistName.text = album.artists.map{ $0.name }.joined(separator: ", ")
        self.albumTitleLabel.text = album.name
        let url = album.images.first?.url ?? ""
        self.image.sd_setImage(with: URL(string: url)){ [weak self] (image, error, _, _) in
            if error == nil, let image = image {
                self?.setupGradientBackground()
            }
        }
        
        let urlArtist = album.artists.first?.images?.first?.url ?? ""
        self.artistImage.sd_setImage(with: URL(string: url))
    }
}

