//
//  FetchData.swift
//  CollectionImage
//
//  Created by Никита Гуляев on 04.12.2021.
//

import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    private init () {}
    
    func downloaded(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else { return }
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}
