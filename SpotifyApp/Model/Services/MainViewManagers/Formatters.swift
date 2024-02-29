//
//  Formatters.swift
//  SpotifyApp
//
//  Created by A Mairam on 10/1/24.
//

import Foundation

class Formatters {

    static func formatReleaseDate(_ dateStr: String) -> String {
        let inputFormatter = ISO8601DateFormatter()
        if let date = inputFormatter.date(from: dateStr) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM"
            return outputFormatter.string(from: date)
        } else {
            return dateStr
        }
    }


    static func formatDuration(_ durationMillis: Int) -> String {
        let totalSeconds = durationMillis / 1000
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60

        return String(format: "%02d:%02d", hours, minutes)
    }

}
