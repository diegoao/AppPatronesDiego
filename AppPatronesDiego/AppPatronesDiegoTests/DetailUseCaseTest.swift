//
//  DetailUseCaseTest.swift
//  AppPatronesDiegoTests
//
//  Created by Macbook Pro on 28/1/24.
//

import XCTest
@testable import AppPatronesDiego

final class DetailUseCaseTest: XCTestCase {
    
    func testDetailUseCaseFakeSuccess() {
        
        // Configurar el objeto HomeUseCaseFakeSuccess
        let detailUseCaseFakeSuccess = DetailUseCaseFakeSuccess()
        
        // Configurar expectativas
        let expectation = expectation(description: "DetailUseCase Success")
        
        detailUseCaseFakeSuccess.getDetail { heroe in
            XCTAssertNotNil(heroe)
            expectation.fulfill()
        } onError: { error in
            XCTFail("Unexpected error: \(error)")
            expectation.fulfill()
        }
        // Esperar a que se cumplan las expectativas
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDetailUseCaseFakeError(){
        
        //tipo de error
        let errorUrl = NetworkError.malformedURL
        // Configurar el objeto HomeUseCaseFakeSuccess
        let detailUseCaseFakeError = DetailUseCaseFakeError()
        
        // Configurar expectativas
        let expectation = expectation(description: "DetailUseCase Error")
        
        detailUseCaseFakeError.getDetail { error in
            XCTFail("Unexpected success")
            expectation.fulfill()
        } onError: { NetworkError in
            XCTAssertEqual(NetworkError, errorUrl)
            expectation.fulfill()
        }
        // Esperar a que se cumplan las expectativas
        wait(for: [expectation], timeout: 5.0)
    }
}
