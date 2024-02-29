//
//  File.swift
//  SpotifyApp
//
//  Created by A Mairam on 6/1/24.
//

import Foundation

protocol PlayerViewControllerDelegate: AnyObject {
    
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
}
