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
    
    func fetchCharacters(status: String?) async throws -> [CharacterVM] {
        page = 1
        return try await repository.fetchCharacters(params: getParameters(status)).mapToCharacterVM()
    }
    
    func loadMoreCharacters(status: String?) async throws -> [CharacterVM] {
        page += 1
        return try await repository.fetchCharacters(params: getParameters(status)).mapToCharacterVM()
    }
    
    private func getParameters( _ status: String?) -> [String: Any] {
        var params: [String: Any] = [:]
        params["page"] = page
        params["status"] = status
        return params
    }
}
