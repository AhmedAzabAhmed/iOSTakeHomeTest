//
//  MockCharacterRepository.swift
//  iOSTakeHomeTestTests
//
//  Created by Ahmed Azab on 07/12/2024.
//

import XCTest
import Combine
@testable import iOSTakeHomeTest

final class MockCharacterRepository: CharacterRepository {
    var fetchCharactersResult: Swift.Result<CharacterResponse, Error>?
    
    func fetchCharacters(params: [String: Any]) async throws -> CharacterResponse {
        switch fetchCharactersResult {
        case .success(let response):
            return response
            
        case .failure(let error):
            throw error
            
        case .none:
            throw URLError(.badServerResponse)
        }
    }
}

