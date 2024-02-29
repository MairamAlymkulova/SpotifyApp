//
//  AlbumViewController+Extention.swift
//  SpotifyApp
//
//  Created by A Mairam on 8/1/24.
//

import Foundation

extension AlbumViewController: TrackTableViewDelegate {
    func didTapTrack(_ track: AudioTrack) {
        PlayerPresenter.shared.startPlayback(from: self, track: track)
    }
}
