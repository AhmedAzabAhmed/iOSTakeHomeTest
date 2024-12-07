//
//  DataProcessor.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import Foundation

final class DataProcessor {
    static let shared = DataProcessor()
    
    private init() {}
    
    func decode<T: Decodable>(_ data: Data, to type: T.Type) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
