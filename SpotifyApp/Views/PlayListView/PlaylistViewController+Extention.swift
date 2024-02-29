//
//  PlayerViewController+Extention.swift
//  SpotifyApp
//
//  Created by A Mairam on 7/1/24.
//

import UIKit

extension PlaylistViewController: TrackTableViewDelegate{
    
    func didTapTrack(_ track: AudioTrack) {
        PlayerPresenter.shared.startPlayback(from: self, track: track)
    }
}
