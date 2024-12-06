//
//  CharacterUseCase.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation

final class CharacterUseCase {
    
    private let repository: CharacterRepository
    private var page: Int = 1
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
    
    func fetchCharacters() async throws -> CharacterResponse {
        page = 1
        return try await repository.fetchCharacters(page: page)
    }
    
    func loadMoreCharacters() async throws -> CharacterResponse {
        page += 1
        return try await repository.fetchCharacters(page: page)
    }
}
