//
//  CharacterRepository.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation

protocol CharacterRepository {
    func fetchCharacters(params: [String: Any]) async throws -> CharacterResponse
}
