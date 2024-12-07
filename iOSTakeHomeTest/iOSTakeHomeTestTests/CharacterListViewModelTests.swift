//
//  CharacterListViewModelTests.swift
//  CharacterListViewModelTests
//
//  Created by Ahmed Azab on 07/12/2024.
//

import XCTest
import Combine
@testable import iOSTakeHomeTest

final class CharacterListViewModelTests: XCTestCase {
    
    private var viewModel: CharacterListViewModel!
    private var useCase: CharacterUseCase!
    private var repository: MockCharacterRepository!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        cancellables = []
        repository = MockCharacterRepository()
        useCase = CharacterUseCase(repository: repository)
        viewModel = CharacterListViewModel(useCase: useCase)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        useCase = nil
        repository = nil
        cancellables = nil
    }
    
    func testFetchCharactersSuccess() async throws {

        let charactersResponse = CharacterResponse(
            info: nil,
            results: [Result(
                id: 1,
                name: "Ali mohamed",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: nil,
                location: nil,
                image: "https://nice.com/rick.png",
                episode: nil,
                url: "https://nice.com/rick",
                created: "2024-12-07T12:34:56Z"
            )]
        )
        repository.fetchCharactersResult = .success(charactersResponse)
        let expectation = XCTestExpectation(description: "Fetch characters successfully")
        
        viewModel.charactersSubject
            .sink { state in
                switch state {
                case .loading:
                    break
                    
                case .success(let result):
                    XCTAssertFalse(result.isEmpty, "Result should not be empty")
                    expectation.fulfill()
                    
                case .failure(let error):
                    XCTFail("Expected success but received failure with error: \(error)")
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchCharacters()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }

    func testFetchCharactersFailure() async throws {
        let error = URLError(.notConnectedToInternet)
        repository.fetchCharactersResult = .failure(error)
        let expectation = XCTestExpectation(description: "Fetch characters failure")
        
        viewModel.charactersSubject
            .sink { state in
                switch state {
                case .loading:
                    break
                    
                case .success:
                    XCTFail("Expected failure but received success")
                    
                case .failure(let receivedError):
                    XCTAssertEqual((receivedError as? URLError)?.code, error.code, "Error codes do not match")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchCharacters()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }

    func testLoadMoreCharactersSuccess() async throws {
        let charactersResponse = CharacterResponse(
            info: nil,
            results: [Result(
                id: 1,
                name: "Summer",
                status: "Dead",
                species: "Human",
                type: "",
                gender: "Female",
                origin: nil,
                location: nil,
                image: "https://nice.com/rick.png",
                episode: nil,
                url: "https://nice.com/rick",
                created: "2024-12-07T12:34:56Z"
            )]
        )
        repository.fetchCharactersResult = .success(charactersResponse)
        let expectation = XCTestExpectation(description: "Load more characters successfully")
        
        viewModel.moreCharactersSubject
            .sink { state in
                switch state {
                case .loading:
                    break
                    
                case .success(let result):
                    XCTAssertFalse(result.isEmpty, "Result should not be empty")
                    expectation.fulfill()
                    
                case .failure(let error):
                    XCTFail("Expected success but received failure with error: \(error)")
                }
            }
            .store(in: &cancellables)

        viewModel.loadMoreCharacters()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }

}
