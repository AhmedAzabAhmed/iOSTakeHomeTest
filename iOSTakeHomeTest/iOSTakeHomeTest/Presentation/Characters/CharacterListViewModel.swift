//
//  CharacterListViewModel.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation
import Combine

final class CharacterListViewModel {
    
    private let useCase: CharacterUseCase
    private var characters: [CharacterVM] = []
    let charactersSubject = PassthroughSubject<ScreenState<[CharacterVM]>, Never>()
    let moreCharactersSubject = PassthroughSubject<ScreenState<[CharacterVM]>, Never>()
    private var status: String?
    
    init(useCase: CharacterUseCase) {
        self.useCase = useCase
    }
    
    func setStatus(_ value: String?) {
        status = value
    }
    
    func fetchCharacters() {
        charactersSubject.send(.loading)
        Task {
            do {
                let result = try await useCase.fetchCharacters(status: status)
                characters.removeAll()
                characters.append(contentsOf: result)
                charactersSubject.send(.success(characters))
                
            } catch {
                charactersSubject.send(.failure(error))
            }
        }
    }
    
    func loadMoreCharacters() {
        moreCharactersSubject.send(.loading)
        Task {
            do {
                let result = try await useCase.loadMoreCharacters(status: status)
                characters.append(contentsOf: result)
                moreCharactersSubject.send(.success(characters))
                
            } catch {
                moreCharactersSubject.send(.failure(error))
            }
        }
    }
}
