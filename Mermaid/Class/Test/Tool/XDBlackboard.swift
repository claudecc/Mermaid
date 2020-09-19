//
//  XDBlackboard.swift
//  Mermaid
//
//  Created by 蔡晓东 on 2020/9/16.
//  Copyright © 2020 claudechoi. All rights reserved.
//

import UIKit

class XDBlackboard: NSObject {
    
    func anything() {
        let path = Bundle.main.path(forResource: "", ofType: "")
        let url = NSURL(fileURLWithPath: path!)
        
        guard let imageSource = CGImageSourceCreateWithURL(url, nil) else { return }
        
        let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)

        let options: [NSString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: 100,
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]

        let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)
    }
    
    func resizingImage(image: UIImage?) -> UIImage? {
        guard let image = image else { return nil }
        
        let maxWidth = screenWidth
        var size = image.size
        if size.width > maxWidth {
            let scale = size.width / size.height
            size.height = maxWidth / scale
            size.width = maxWidth
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { (context) in
            image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        
        return resizedImage
    }

    // bad sample
    func applyBad(image: UIImage) -> UIImage? {
        var filteredImage: UIImage? = nil
        
        if let ci = CIImage(image: image) {
            let rect = CGRect(origin: CGPoint.zero, size: image.size)
            
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
            
            if let quartzContext = UIGraphicsGetCurrentContext() {
                let ciCOntext = CIContext(cgContext: quartzContext, options: nil)
                
                if let filter = CIFilter(name: "CIPhotoEffectNoir", parameters: [kCIInputImageKey: ci as Any]),
                    let outputImage = filter.outputImage,
                    let cgImage = ciCOntext.createCGImage(outputImage, from: rect) {
                    
                    let noirImage = UIImage(cgImage: cgImage)
                    if let pngData = noirImage.pngData() {
                        filteredImage = UIImage(data: pngData)
                    }
                    
                }
                
            }
            
            UIGraphicsEndImageContext()
            
        }
        
        return filteredImage
    }
    
    // good sample
    func applyGood(image: UIImage) -> UIImage? {
        var filteredImage: UIImage? = nil
        
        if let ci = CIImage(image: image) {
            let rect = CGRect(origin: CGPoint.zero, size: image.size)
            
            let renderer = UIGraphicsImageRenderer(size: rect.size)
            let image = renderer.image { (context) in
                let ciContext = CIContext(cgContext: context.cgContext, options: nil)
                
                if let filter = CIFilter(name: "CIPhotoEffectNoir", parameters: [kCIInputImageKey: ci as Any]),
                    let outputImage = filter.outputImage {
                    ciContext.draw(outputImage, in: rect, from: rect)
                }
            }
            filteredImage = image
            
        }
        
        return filteredImage
    }
    
    func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {

        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary

        let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!

        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale

        let downsampleOptions =
            [kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary

        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!

        return UIImage(cgImage: downsampledImage)

    }
    
    
}
