//
//  CharacterVM.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation

struct CharacterVM {
    let name: String
    let image: String
    let species: String
    let status: String
    let gender: String
}

extension CharacterResponse {
    func mapToCharacterVM() -> [CharacterVM] {
        self.results?.map({
            CharacterVM(
                name: $0.name ?? "",
                image: $0.image ?? "",
                species: $0.species ?? "",
                status: $0.status ?? "",
                gender: $0.gender ?? ""
            )
        }) ?? []
    }
}

enum StatusFilter: String, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}

