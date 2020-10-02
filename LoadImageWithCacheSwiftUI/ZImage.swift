//
//  SwiftUIView.swift
//  LoadImageWithCacheSwiftUI
//
//  Created by Nelson Gonzalez on 2/20/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct ZImage<ErrorView: View, ImageView: View, LoadingView: View>: View {
    
    private let url: URL
    private let errorView: (Error) -> ErrorView
    private let imageView: (Image) -> ImageView
    private let loadingView: () -> LoadingView
    
    @ObservedObject private var service = ImageService()
    
    init(url: URL, @ViewBuilder errorView: @escaping (Error) -> ErrorView, @ViewBuilder imageView: @escaping (Image) -> ImageView, @ViewBuilder loadingView: @escaping () -> LoadingView) {
        self.url = url
        self.errorView = errorView
        self.imageView = imageView
        self.loadingView = loadingView
    }
    
    var body: AnyView {
        switch service.state {
        case .error(let error):
            return AnyView(errorView(error))
        case .image(let image):
        return AnyView(imageView(Image(uiImage: image)))
        case .loading:
            return AnyView(loadingView().onAppear {
                self.service.loadImage(url: self.url)
            })
        }
    }
}
