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
    
    func fetchCharacters() async throws -> [CharacterVM] {
        page = 1
        return try await repository.fetchCharacters(page: page).mapToCharacterVM()
    }
    
    func loadMoreCharacters() async throws -> [CharacterVM] {
        page += 1
        return try await repository.fetchCharacters(page: page).mapToCharacterVM()
    }
}
