//
//  MainViewController.swift
//  SpotifyApp
//
//  Created by A Mairam on 10/1/24.
//


import UIKit
import Alamofire
import AlamofireImage

class MainViewController: UIViewController {
    
    var userName: String = ""
    var tracksData: [TrackData] = []
    var podcastsData: [PodcastData] = []
    var albumsData: [AlbumsData] = []
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = true
        sv.isScrollEnabled = true
        //tv.alwaysBounceVertical = true
        sv.indicatorStyle = .black
        return sv
    }()


    let cornerImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "corner_image"))
        return img
    }()
    
    let welcomeLabel: UILabel = {
        let lbl = UILabel()
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<6:
            lbl.text = "Good night"
        case 6..<12:
            lbl.text = "Good morning"
        case 12..<18:
            lbl.text = "Good afternoon"
        case 18..<24:
            lbl.text = "Good evening"
        default:
            lbl.text = "Hello"
        }

        lbl.textColor = .white
        lbl.font = UIFont(name: ConstantsForUIComponents().fontBold, size: ConstantsForUIComponents().fontSizeLabel)
            return lbl
    }()
    
    let buttonGear: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "gear"), for: .normal)
        return btn
    }()
    
    let buttonClock: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "clock"), for: .normal)
        return btn
    }()
    
    let buttonBell: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "bell"), for: .normal)
        return btn
    }()
    
    let buttonStack: UIStackView = {
        let stck = UIStackView()
        stck.axis = .horizontal
        stck.spacing = 16
        return stck
    }()
    
    let songsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (UIScreen.main.bounds.width - ConstantsForUIComponents().marging * 2 - ConstantsForUIComponents().lineSpacing) / 2
        layout.itemSize = CGSize(width: itemWidth, height: ConstantsForUIComponents().imageSongWidth)

        layout.minimumLineSpacing = ConstantsForUIComponents().lineSpacing
        layout.minimumInteritemSpacing = ConstantsForUIComponents().interItemSpacing
        layout.scrollDirection = .horizontal
        //layout.sectionInset = sectionInset
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    let podcastNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "New Episodes"
        lbl.font = UIFont(name: ConstantsForUIComponents().fontBold, size: ConstantsForUIComponents().fontSizeLabel)
        lbl.textColor = .white
        return lbl
    }()
    
    let podcastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var itemWidth = ConstantsForUIComponents().podcastCellWidth
        
        if (UIScreen.main.bounds.width - ConstantsForUIComponents().marging * 2) < ConstantsForUIComponents().podcastCellWidth {
            
            itemWidth = UIScreen.main.bounds.width - ConstantsForUIComponents().marging * 2
        }
        
        layout.itemSize = CGSize(width: itemWidth, height: ConstantsForUIComponents().imagePodcastWidth)
        layout.minimumLineSpacing = ConstantsForUIComponents().lineSpacing
        layout.minimumInteritemSpacing = ConstantsForUIComponents().interItemSpacing
        layout.scrollDirection = .horizontal
        //layout.sectionInset = sectionInset
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .black
        return cv
    }()
    
    let albumsNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Recent Albums"
        lbl.font = UIFont(name: ConstantsForUIComponents().fontBold, size: ConstantsForUIComponents().fontSizeLabel)
        lbl.textColor = .white
        return lbl
    }()
    
    let albumsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (UIScreen.main.bounds.width - ConstantsForUIComponents().marging * 2 - ConstantsForUIComponents().lineSpacing) / 2
        layout.itemSize = CGSize(width: itemWidth, height: ConstantsForUIComponents().imageSongWidth)

        layout.minimumLineSpacing = ConstantsForUIComponents().lineSpacing
        layout.minimumInteritemSpacing = ConstantsForUIComponents().interItemSpacing
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        AlbumManager.shared.getNewAlbums { [weak self] (podcastInfo) in
            
            // Обновляем массив подкастов и перезагружаем collectionView на главном потоке
            DispatchQueue.main.async {
                self?.albumsData = podcastInfo
                print("Albums \(podcastInfo.count)")
                self?.albumsCollectionView.reloadData()
            }
        }
        PodcastsManager.shared.getPodcasts { [weak self] (podcastInfo) in
            // Обновляем массив подкастов и перезагружаем collectionView на главном потоке

            DispatchQueue.main.async {
                self?.podcastsData = podcastInfo
                print("Podcast \(self?.podcastsData.count)")

                self?.podcastCollectionView.reloadData()
            }
        }
        TracksManager.shared.getSongs{ [weak self] (songInfo) in
            // Обновляем массив треков и перезагружаем collectionView на главном потоке
            DispatchQueue.main.async {
                self?.tracksData = songInfo
                print("Tracks \(songInfo.count)")

                self?.songsCollectionView.reloadData()
            }
        }

        initUI()

        
    }

    func initUI() {

        let playerView = PlayerView()
        view.addSubview(scrollView)
        view.backgroundColor = .black
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            ])
        

        scrollView.addSubview(cornerImage)
        cornerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cornerImage.topAnchor.constraint(equalTo: view.topAnchor),
            cornerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        scrollView.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: ConstantsForUIComponents().marging)
        ])
        
        scrollView.addSubview(buttonStack)
        buttonStack.addArrangedSubview(buttonBell)
        buttonStack.addArrangedSubview(buttonClock)
        buttonStack.addArrangedSubview(buttonGear)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: welcomeLabel.topAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
        songsCollectionView.dataSource = self
        songsCollectionView.delegate = self
        songsCollectionView.register(SongsCollectionViewCell.self, forCellWithReuseIdentifier: "cellSong")
        
        scrollView.addSubview(songsCollectionView)
        songsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songsCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - ConstantsForUIComponents().marging * 2),
            songsCollectionView.heightAnchor.constraint(equalToConstant: ConstantsForUIComponents().imageSongWidth * 3 + ConstantsForUIComponents().marging),
            songsCollectionView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 15),
            songsCollectionView.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor)
        ])
        
        scrollView.addSubview(podcastNameLabel)
        podcastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            podcastNameLabel.topAnchor.constraint(equalTo: songsCollectionView.bottomAnchor, constant: 30),
            podcastNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: ConstantsForUIComponents().marging)
        ])
        
        podcastCollectionView.dataSource = self
        podcastCollectionView.delegate = self
        podcastCollectionView.register(PodcastCollectionViewCell.self, forCellWithReuseIdentifier: "cellPodcast")
        
        scrollView.addSubview(podcastCollectionView)
        podcastCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            podcastCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - ConstantsForUIComponents().marging * 2),
            podcastCollectionView.heightAnchor.constraint(equalToConstant: ConstantsForUIComponents().imagePodcastWidth * 2 + ConstantsForUIComponents().interItemSpacing),
            podcastCollectionView.topAnchor.constraint(equalTo: podcastNameLabel.bottomAnchor, constant: 15),
            podcastCollectionView.leadingAnchor.constraint(equalTo: songsCollectionView.leadingAnchor)
        ])
        
        scrollView.addSubview(albumsNameLabel)
        albumsNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumsNameLabel.topAnchor.constraint(equalTo: podcastCollectionView.bottomAnchor, constant: 30),
            albumsNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: ConstantsForUIComponents().marging)
        ])
        

        albumsCollectionView.dataSource = self
        albumsCollectionView.delegate = self
        albumsCollectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: "cellAlbum")
    
        scrollView.addSubview(albumsCollectionView)
        albumsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumsCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - ConstantsForUIComponents().marging * 2),
            albumsCollectionView.heightAnchor.constraint(equalToConstant: ConstantsForUIComponents().imageSongWidth * 3 + ConstantsForUIComponents().marging),
            albumsCollectionView.topAnchor.constraint(equalTo: albumsNameLabel.bottomAnchor, constant: 15),
            albumsCollectionView.leadingAnchor.constraint(equalTo: albumsNameLabel.leadingAnchor)
        ])
        
        
            
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsForUIComponents().marging),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ConstantsForUIComponents().marging),
            playerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - ConstantsForUIComponents().marging * 2),
            playerView.heightAnchor.constraint(equalToConstant: ConstantsForUIComponents().playerSongImageWidth),
            playerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        tabBarController?.tabBar.standardAppearance.backgroundColor = .black
    }
    
    
}


extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == songsCollectionView {
            return tracksData.count
        } else if collectionView == albumsCollectionView {
            // Возвращайте количество элементов в массиве альбомов
            return albumsData.count
        } else if collectionView == podcastCollectionView {
            return podcastsData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()

        switch collectionView {
        case songsCollectionView:
    
//            if albumsData.isEmpty {
//                    print("Albums data is empty")
//                } else {
//                    print("Albums data is not empty \(albumsData.first)")
//                }
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSong", for: indexPath) as! SongsCollectionViewCell
            if !tracksData.isEmpty {
                let trackInfo = tracksData[indexPath.item]
                (cell as! SongsCollectionViewCell).cellLabel.text = trackInfo.name
                if let imageUrl = URL(string: trackInfo.imageUrl) {
                    (cell as! SongsCollectionViewCell).cellImage.af.setImage(withURL: imageUrl)
                }
            }

        case podcastCollectionView:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPodcast", for: indexPath) as! PodcastCollectionViewCell
            if !podcastsData.isEmpty {
                let cell_ = (cell as! PodcastCollectionViewCell)
                let podcastData = podcastsData[indexPath.item]
                cell_.cellMainLabel.text = podcastData.name
                cell_.cellSecondLabel.text = podcastData.description
                cell_.cellInfoLabel.text = "\(Formatters.formatReleaseDate(podcastData.date))" + " ~ " + "\(Formatters.formatDuration(podcastData.duration))"
                if let imageUrl = URL(string: podcastData.imageUrl) {
                    (cell as! PodcastCollectionViewCell).cellImage.af.setImage(withURL: imageUrl)
                }
            }

        case albumsCollectionView:

            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAlbum", for: indexPath) as! AlbumsCollectionViewCell
            if !albumsData.isEmpty {
                let albumInfo = albumsData[indexPath.item]
                (cell as! AlbumsCollectionViewCell).cellLabel.text = albumInfo.name
                if let imageUrl = URL(string: albumInfo.imageUrl) {
                    (cell as! AlbumsCollectionViewCell).cellImage.af.setImage(withURL: imageUrl)
                }
            }

        default:
            break

        }

        return cell
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.performWithoutAnimation {
            self.tabBarController?.tabBar.barTintColor = .black
        }
    }
}


extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
}



