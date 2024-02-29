//
//  GardientManager.swift
//  SpotifyApp
//
//  Created by A Mairam on 7/1/24.
//

import Foundation

import UIKit

class GradientManager {
    
    static func addGradient(to view: UIView, colors: [UIColor], direction: GradientDirection) {

        view.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        
        switch direction {
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        }
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

enum GradientDirection {
    case vertical
    case horizontal
}
