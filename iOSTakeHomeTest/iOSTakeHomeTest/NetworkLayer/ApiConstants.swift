//
//  ApiConstants.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation

struct ApiConstants {
    
    static let baseURL = "https://rickandmortyapi.com/api/character"
}

extension ApiConstants {
    enum Errors: String, Error {
        case genericError
    }
}
