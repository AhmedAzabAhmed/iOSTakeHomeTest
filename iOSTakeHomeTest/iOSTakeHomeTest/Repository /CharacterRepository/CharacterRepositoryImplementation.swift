//
//  CharacterRepositoryImplementation.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation

final class CharacterRepositoryImplementation: CharacterRepository {
    func fetchCharacters(params: [String: Any]) async throws -> CharacterResponse {
        var urlString = ApiConstants.baseURL
        
        if !params.isEmpty {
            urlString += "?" + params.compactMap { key, value -> String? in
                return "\(key)=\(value)"
            }.joined(separator: "&")
        }
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let rawData = try await NetworkManager.shared.request(url: url)
        return try DataProcessor.shared.decode(rawData, to: CharacterResponse.self)
    }
}
