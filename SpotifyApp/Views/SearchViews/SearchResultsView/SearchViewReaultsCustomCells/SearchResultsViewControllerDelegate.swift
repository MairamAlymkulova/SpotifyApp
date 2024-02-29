//
//  SearchResultsViewControllerProtocol.swift
//  SpotifyApp
//
//  Created by A Mairam on 3/1/24.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject{
    func didTapResults(_ result: SearchResults)
}
