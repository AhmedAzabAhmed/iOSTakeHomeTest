//
//  CharacterRepositoryImplementation.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation

final class CharacterRepositoryImplementation: CharacterRepository {
    func fetchCharacters(page: Int) async throws -> CharacterResponse {
        guard let url = URL(string: "\(ApiConstants.baseURL)?page=\(page)") else {
            throw URLError(.badURL)
        }
        let rawData = try await NetworkManager.shared.request(url: url)
        return try DataProcessor.shared.decode(rawData, to: CharacterResponse.self)
    }
}
