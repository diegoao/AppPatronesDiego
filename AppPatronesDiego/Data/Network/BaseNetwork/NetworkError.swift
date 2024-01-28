//
//  NetworkError.swift
//  AppPatronesDiego
//
//  Created by Macbook Pro on 26/1/24.
//

import Foundation

enum NetworkError: Error, Equatable {
    case malformedURL
    case dataFormatting
    case other
    case noData
    case errorCode(Int?)
    case tokenFormatError
    case decoding
}
