//
//  PlayerCollectionViewCell.swift
//  SpotifyApp
//
//  Created by A Mairam on 28/12/23.
//

import UIKit

class PlayerViewController: UIViewController {
    var track: AudioTrack
    
    private let gradientView = CAGradientLayer()
    
    private var playMusic = true
    
    weak var delegate: PlayerViewControllerDelegate?
    
    private let pause = UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))

    private let play = UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))

    private var playerTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reasonable Doubt"
        return label
    }()
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "opticaldisc.fill")
        imageView.tintColor = .white
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "album_cover")
        return imageView
    }()
    
    private let songTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Song Title"
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Artist Name"
        return label
    }()
    
    
    private let musicSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(systemName: ""), for: .normal)
        slider.tintColor = .white
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "forward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .thin))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let prevButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "backward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .thin))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let repeatButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "repeat", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shuffleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "shuffle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let deviceButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "hifispeaker.2", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "line.3.horizontal", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let minimizePlayerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let getMoreInformationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var musicPlayerStack: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [shuffleButton, prevButton, playPauseButton, nextButton, repeatButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var shareListButtonsStack: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [shareButton, playlistButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 35
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var deviceShareButtonsStack: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [deviceButton, shareListButtonsStack]
        )
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    init(track: AudioTrack) {
        self.track = track
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorManager.shared.grayForPlayerBackground
        gradientView.frame = view.bounds
        view.layer.addSublayer(gradientView)
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(playerTitleLabel)
        view.addSubview(minimizePlayerButton)
        view.addSubview(getMoreInformationButton)
        view.addSubview(albumImageView)
        view.addSubview(songTitleLabel)
        view.addSubview(artistLabel)
        view.addSubview(musicSlider)
        
        view.addSubview(musicPlayerStack)
        view.addSubview(deviceButton)
        view.addSubview(shareButton)
        view.addSubview(deviceShareButtonsStack)
        
        
        setValues()
        NSLayoutConstraint.activate([
            
            
            minimizePlayerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            minimizePlayerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            minimizePlayerButton.widthAnchor.constraint(equalToConstant: 35),
            minimizePlayerButton.heightAnchor.constraint(equalToConstant: 35),
            
            getMoreInformationButton.centerYAnchor.constraint(equalTo: minimizePlayerButton.centerYAnchor),
            getMoreInformationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            getMoreInformationButton.widthAnchor.constraint(equalToConstant: 35),
            getMoreInformationButton.heightAnchor.constraint(equalToConstant: 35),
            
            playerTitleLabel.centerYAnchor.constraint(equalTo: minimizePlayerButton.centerYAnchor),
            playerTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            albumImageView.topAnchor.constraint(equalTo: playerTitleLabel.bottomAnchor, constant: 20),
            albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumImageView.widthAnchor.constraint(equalToConstant: UIView.screenWidth - 40),
            albumImageView.heightAnchor.constraint(equalToConstant: UIView.screenWidth - 40),
            
            musicSlider.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 20),
            musicSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            musicSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            songTitleLabel.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 20),
            songTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            artistLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 2),
            artistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            artistLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            musicPlayerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            musicPlayerStack.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 40),
            musicPlayerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            musicPlayerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            deviceShareButtonsStack.topAnchor.constraint(equalTo: musicPlayerStack.bottomAnchor, constant: 30),
            deviceShareButtonsStack.leadingAnchor.constraint(equalTo: musicPlayerStack.leadingAnchor, constant: 4),
            deviceShareButtonsStack.trailingAnchor.constraint(equalTo: musicPlayerStack.trailingAnchor, constant: -4)

        ])
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
        minimizePlayerButton.addTarget(self, action: #selector(minimizePlayerButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func playPauseButtonTapped() {
        playMusic.toggle()
        delegate?.didTapPlayPause()
        
        playPauseButton.setImage(playMusic ? pause : play, for: .normal)
        
    }
    
    @objc private func nextButtonTapped() {
        delegate?.didTapForward()
        playMusic = false
        playPauseButton.setImage(play, for: .normal)

    }
    
    @objc private func prevButtonTapped() {
        delegate?.didTapBackward()
        
    }
    
    @objc private func minimizePlayerButtonTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    private func setupGradientBackground () {

        if let image = albumImageView.image {
                let imageColor = image.averageColor()
            gradientView.colors = [imageColor.cgColor, ColorManager.shared.grayForPlayerBackground.cgColor]
            } else {
                gradientView.colors = [ColorManager.shared.grayForPlayerBackground.cgColor]
            }
    }
    
    func setValues(){

        self.playerTitleLabel.text = self.track.album?.name
        self.artistLabel.text = self.track.artists.map { $0.name }.joined(separator: ", ")
        
        let url = track.album?.images.first?.url ?? ""
        self.albumImageView.sd_setImage(with: URL(string: url))
        { [weak self] (image, error, _, _) in
            if error == nil, let image = image {
                self?.setupGradientBackground()
            }
        }
        self.songTitleLabel.text = self.track.name
        
    }
}
