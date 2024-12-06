//
//  NetworkManager.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(
        url: URL,
        responseType: T.Type
    ) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
