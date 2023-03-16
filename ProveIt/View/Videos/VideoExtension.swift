//
//  VideoExtension.swift
//  Prove It
//
//  Created by Lara Pereira on 25/02/23.
//

import SwiftUI
import AVKit
import UIKit

struct GifView: UIViewRepresentable {
    let gifName: String
    
    func makeUIView(context: Context) -> UIView {
        let imageView = UIImageView()
        let gif = UIImage.gifImageWithName(gifName)
        imageView.image = gif
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Nada aqui
    }
}

extension UIImage {
    static func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
                .url(forResource: name, withExtension: "gif") else {
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            return nil
        }
        return UIImage.gifImageWithData(imageData)
    }
    
    static func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        let count = CGImageSourceGetCount(source)
        var images = [UIImage]()
        var duration = 0.0
        for i in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                continue
            }
            let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil)
            if let gifInfo = (properties as? [String: Any])?["{GIF}"] as? [String: Any] {
                if let delayTime = gifInfo["UnclampedDelayTime"] as? Double {
                    duration += delayTime
                }
            }
            images.append(UIImage(cgImage: cgImage))
        }
        return UIImage.animatedImage(with: images, duration: duration)
    }
}
