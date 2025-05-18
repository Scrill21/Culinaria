//
//  ImageView.swift
//  Culinaria
//
//  Created by anthony byrd on 5/16/25.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageDownloader: ImageDownloader
    
    init(urlString: String) {
        imageDownloader = ImageDownloader(urlString: urlString)
    }
    
    var body: some View {
        if let image = imageDownloader.image {
            image
                .resizable()
        }
    }
}

#Preview {
    ImageView(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
}
