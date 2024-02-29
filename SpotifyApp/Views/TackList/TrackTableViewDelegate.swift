//
//  TrackTableViewDelegate.swift
//  SpotifyApp
//
//  Created by A Mairam on 7/1/24.
//

import Foundation

protocol TrackTableViewDelegate: AnyObject {
    func didTapTrack (_ track: AudioTrack)
}
