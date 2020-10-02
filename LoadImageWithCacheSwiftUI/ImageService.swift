//
//  ImageService.swift
//  LoadImageWithCacheSwiftUI
//
//  Created by Nelson Gonzalez on 2/20/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Combine
import UIKit

enum ImageError: Error {
    case imageDamaged
}

class ImageService: ObservableObject {
    private var cancellable: AnyCancellable?
    static let cache = NSCache<NSURL, UIImage>()
    @Published var state: ImageState = .loading
    
    func loadImage(url: URL) {
        //When this function is executed stop requests if they are happening
        cancellable?.cancel()
        
        //check if the url var is already in memory.
        if let image = ImageService.cache.object(forKey: url as NSURL) {
            //retrive image if loaded and pass it to the state variable.
            state = .image(image)
            return
        }
        
       //Download image.
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        cancellable = urlSession.dataTaskPublisher(for: urlRequest).map { UIImage(data: $0.data) }.receive(on: RunLoop.main).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure(let failure):
                self.state = .error(failure)
            default: ()
            }
        }, receiveValue: { (image) in
            if let image = image {
                ImageService.cache.setObject(image, forKey: url as NSURL)
                self.state = .image(image)
            } else {
                self.state = .error(ImageError.imageDamaged)
            }
        })
    }
}

extension ImageError: LocalizedError {
    var errorDescription: String? {
        return "Can not load image from the URL"
    }
}
