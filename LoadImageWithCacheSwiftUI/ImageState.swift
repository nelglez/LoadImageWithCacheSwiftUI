//
//  ImageState.swift
//  LoadImageWithCacheSwiftUI
//
//  Created by Nelson Gonzalez on 2/20/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import UIKit

enum ImageState {
    case error(_ error: Error)
    case image(_ image: UIImage)
    case loading
}
