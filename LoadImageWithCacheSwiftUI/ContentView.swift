//
//  ContentView.swift
//  LoadImageWithCacheSwiftUI
//
//  Created by Nelson Gonzalez on 2/20/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var url = URL(string: "https://www.filepicker.io/api/file/Ae0Ll48EQWJ8HhkVcNHZ")!
    var body: some View {
        ZImage(url: url, errorView: { error in
            Text(error.localizedDescription)
        }, imageView: { image in
            image.resizable().aspectRatio(contentMode: .fit)
        }, loadingView: {
            Text("Loading...")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
