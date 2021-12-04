//
//  NetworkServiсe.swift
//  CollectionImage
//
//  Created by Никита Гуляев on 04.12.2021.
//

import Foundation

class NetworkService {
    func request(completion: @escaping ([ImageData]) -> ()) {
        guard let url = URL(string: "https://api.opendota.com/api/heroStats") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "error data")
                return
            }
            
            if error == nil {
                do {
                    do {
                        let decoder = JSONDecoder()
                        let hero = try decoder.decode([ImageData].self, from: data)
                        completion(hero)
                    } catch {
                        print(String(describing: error))
                    }
                }
            }
        }.resume()
    }
}

