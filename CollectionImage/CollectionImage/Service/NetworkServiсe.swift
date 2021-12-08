//
//  NetworkServiсe.swift
//  CollectionImage
//
//  Created by Никита Гуляев on 04.12.2021.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

class NetworkService {
    
    static let shared = NetworkService()
    private init () {}
    
    func request() async throws -> [ImageData] {
        guard let url = URL(string: "https://api.opendota.com/api/heroStats") else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        guard let image = try? decoder.decode([ImageData].self, from: data) else {
            throw NetworkError.noData
        }
        
        return image
    }
}

