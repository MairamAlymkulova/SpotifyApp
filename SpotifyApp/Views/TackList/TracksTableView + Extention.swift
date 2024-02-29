//
//  TracksTableView + Extention.swift
//  SpotifyApp
//
//  Created by A Mairam on 7/1/24.
//

import UIKit

extension TracksTableView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tracksCell", for: indexPath) as? CustomCellForTracks
        else {
            return UITableViewCell()
        }

        cell.setValues(track: tracks[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        print(track)
        delegate?.didTapTrack(track)
    }

}



