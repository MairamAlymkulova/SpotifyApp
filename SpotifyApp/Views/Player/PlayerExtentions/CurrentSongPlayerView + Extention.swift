//
//  CurrentSongPlayerView + Extention.swift
//  SpotifyApp
//
//  Created by A Mairam on 6/1/24.
//

import Foundation

extension PlayerViewController: CurrentSongPlayerViewDelegate{
    func currentSongPlayerViewDidDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
