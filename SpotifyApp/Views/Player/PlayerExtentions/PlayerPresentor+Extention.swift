//
//  PlayerPresentor+Extention.swift
//  SpotifyApp
//
//  Created by A Mairam on 6/1/24.
//

import Foundation

extension PlayerPresenter: PlayerViewControllerDelegate{
    
    func didTapPlayPause() {
        guard let player = player else {
            print("player is optional")
            return
        }
        
        if player.timeControlStatus == .paused{
            player.play()
        }
        else if player.timeControlStatus == .playing{
            player.pause()
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty{
            player?.pause()
        }
        else{
            
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty{
            player?.pause()
            player?.play()
        }
        else{
            
        }
    }
    
    
}
