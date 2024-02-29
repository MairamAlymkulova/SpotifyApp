//
//  ColorManager.swift
//  SpotifyApp
//
//  Created by A Mairam on 27/12/23.
//

import UIKit

class ColorManager{
    static let shared = ColorManager()
    var darkGrayBackgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
    var placeHolderGrayColor = UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1)
    var grayForPlayerBackground = UIColor(red: 60/255, green: 61/255, blue: 61/255, alpha: 1)
}

extension UIColor {
    static func random() -> UIColor {
        let spotifyPlaylistColors: [UIColor] = [
            UIColor(red: 21/255, green: 138/255, blue: 6/255, alpha: 1.0),  // Зеленый
            UIColor(red: 82/255, green: 122/255, blue: 161/255, alpha: 1.0), // Голубой
            UIColor(red: 235/255, green: 29/255, blue: 50/255, alpha: 1.0),  // Красный
            UIColor(red: 216/255, green: 64/255, blue: 0/255, alpha: 1.0),  // Оранжевый
            UIColor(red: 132/255, green: 0/255, blue: 231/255, alpha: 1.0),  // Фиолетовый
            UIColor(red: 30/255, green: 50/255, blue: 100/255, alpha: 1.0),  // Синий
            UIColor(red: 71/255, green: 125/255, blue: 148/255, alpha: 1.0),  // Желтый
            UIColor(red: 232/255, green: 16/255, blue: 91/255, alpha: 1.0), // Розовый
            UIColor(red: 38/255, green: 133/255, blue: 107/255, alpha: 1.0), // Салатовый
            UIColor(red: 186/255, green: 93/255, blue: 8/255, alpha: 1.0),   // Коралловый
            UIColor(red: 220/255, green: 20/255, blue: 140/255, alpha: 1.0),    // Фуксия
            UIColor(red: 175/255, green: 40/255, blue: 150/255, alpha: 1.0),    // Fandango
            UIColor(red: 15/255, green: 115/255, blue: 136/255, alpha: 1.0),    // Crayola Blue
            UIColor(red: 225/255, green: 52/255, blue: 0/255, alpha: 1.0),    //
            UIColor(red: 177/255, green: 98/255, blue: 56/255, alpha: 1.0),
            UIColor(red: 71/255, green: 125/255, blue: 148/255, alpha: 1.0),    // Crayola Blue


            UIColor(red: 141/255, green: 104/255, blue: 171/255, alpha: 1.0)    // Trendy Pink

        ]


        return spotifyPlaylistColors.randomElement()!
    }
}
