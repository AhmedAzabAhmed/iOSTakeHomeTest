//
//  CharacterResponse.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation

// MARK: - CharacterResponse
struct CharacterResponse: Codable {
    let info: Info?
    let results: [Result]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next, prev: String?
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}
