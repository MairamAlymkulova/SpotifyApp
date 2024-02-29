//
//  GradientColorManager.swift
//  SpotifyApp
//
//  Created by A Mairam on 7/1/24.
//

import UIKit

extension UIImage {
    func averageColor() -> UIColor {
        guard let inputImage = CIImage(image: self) else {

            return ColorManager.shared.grayForPlayerBackground
        }

        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]),
              let outputImage = filter.outputImage else {
            return ColorManager.shared.grayForPlayerBackground
        }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: nil)
        
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
    }
    
    
}

