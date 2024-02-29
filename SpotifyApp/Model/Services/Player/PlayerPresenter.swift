//
//  PlayerPresenter.swift
//  SpotifyApp
//
//  Created by A Mairam on 3/1/24.
//

import AVFoundation
import UIKit

final class PlayerPresenter{
    
    static var shared = PlayerPresenter()

    var track: AudioTrack?
    var tracks = [AudioTrack]()
    
    var player: AVPlayer?
    var tracksQueue: AVQueuePlayer?
    
    func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    
    ){
        self.track = track
        self.tracks = []
        
        guard let url = URL(string: track.previewUrl ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        let vc = PlayerViewController(track: track)
        vc.delegate = self
        viewController.present(vc, animated: true) {
            self.player?.play()
        }
    }
    
    func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    
    ){
        self.track = nil
        self.tracks = tracks
        
        self.tracksQueue = AVQueuePlayer(items: tracks.compactMap({
            guard let url = URL(string: $0.previewUrl ?? "") else {
                return nil
            }
           return AVPlayerItem(url: url)
        }))
                                         
        self.tracksQueue?.play()
        
    }
    
}
