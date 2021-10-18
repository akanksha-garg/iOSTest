//
//  Image+Extension.swift
//  PokemonTest
//
//  Created by Akanksha Garg on 18/10/21.
//

import UIKit

import SwiftUI

extension Image {
    
    /// Get Image from URL and set to image view.
    ///
    /// - Parameters:
    ///   - url: URL of image
    func data(url:URL) -> Self {
        
        do {
            let data = try Data(contentsOf: url)
            if let image = UIImage(data: data) {
                return Image(uiImage: image)
                    .resizable()
            }
        }
        catch {
            debugPrint("Couldn't Load Image: \(error)")
        }
        return Image("Placeholder")
            .resizable()
    }
}
