//
//  CharacterRepository.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation

protocol CharacterRepository {
    func fetchCharacters(page: Int) async throws -> CharacterResponse
}
