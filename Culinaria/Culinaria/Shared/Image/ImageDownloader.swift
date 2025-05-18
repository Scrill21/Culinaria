//
//  ImageDownloader.swift
//  Culinaria
//
//  Created by anthony byrd on 5/16/25.
//

import SwiftUI

class ImageDownloader: ObservableObject {
    @Published var image: Image?
    
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        
        Task { await loadImageAndSaveToCache() }
    }
    
    @MainActor
    private func loadImageAndSaveToCache() async {
        guard let url = URL(string: urlString) else { return }
        
        // Creating URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        
        // URLCache Configuration
        let memoryCapacity = 20 * 1024 * 1024 // 20MB
        let diskCapacity = 20 * 1024 * 1024 // 20MB
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity)
        URLCache.shared = urlCache
        
        // Session Configuration
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        if let cachedResponse = urlCache.cachedResponse(for: urlRequest) {
            guard let uiImage = UIImage(data: cachedResponse.data) else { return }
            
            print("DEBUG: Received cached image")
            self.image = Image(uiImage: uiImage)
        } else {
            do {
                let (data, response) = try await session.data(from: url)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("DEBUG: Request failed")
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    print("DEBUG: Failed with response status: \(httpResponse.statusCode)")
                    return
                }
                
                guard let uiImage = UIImage(data: data) else {
                    print("DEBUG: Invalid data")
                    return
                }
                
                print("DEBUG: Image fetched from the web")
                
                self.image = Image(uiImage: uiImage)
            } catch {
                self.image = Image(systemName: "photo")
            }
        }
    }
}
