//
//  CharacterImage.swift
//  CollectionImage
//
//  Created by Никита Гуляев on 05.12.2021.
//

import UIKit

class CharacterImage: UIImageView {
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else {
            image = UIImage(systemName: "network")
            return
        }
        // Take an image from the cache if it is there
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        // If there is no image in the cache, then download it from the network
        ImageManager.shared.downloaded(from: url) { data, response in
            self.image = UIImage(data: data)
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
