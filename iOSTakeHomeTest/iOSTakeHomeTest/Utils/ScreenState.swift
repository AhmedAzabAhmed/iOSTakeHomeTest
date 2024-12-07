//
//  ScreenState.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

enum ScreenState<T> {
    case loading
    case success(T)
    case failure(Error)
}
