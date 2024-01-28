//
//  LoginUseCaseTest.swift
//  AppPatronesDiegoTests
//
//  Created by Macbook Pro on 28/1/24.
//

import XCTest
@testable import AppPatronesDiego

class LoginUseCaseTest: XCTestCase {
    
    func testLoginUseCaseFakeSuccess() {
        
        // Configurar el objeto HomeUseCaseFakeSuccess
        let loginUseCaseFakeSuccess = LoginUseCaseFakeSuccess()
        
        // Configurar expectativas
        let expectation = expectation(description: "LoginUseCase Success")
        
        // Hago la llamada al fakeSuccess
        loginUseCaseFakeSuccess.login(user: "user", password: "password") { token in
            XCTAssertNotNil(token)
            expectation.fulfill()
        } onError: { error in
            XCTFail("Unexpected error: \(error)")
            expectation.fulfill()
        }
        
        // Espero a que se cumplan las expectativas
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    func testLoginUseCaseFakeError() {
        
        let noData = NetworkError.noData
        
        // Configurar el objeto HomeUseCaseFakeSuccess
        let loginUseCaseFakeError = LoginUseCaseFakeError()
        
        // Configurar expectativas
        let expectation = expectation(description: "LoginUseCase failure")
        
        //Hago la llamada a fakeError
        loginUseCaseFakeError.login(user: "user", password: "password") { error in
            XCTFail("Unexpected success")
            expectation.fulfill()
        } onError: { NetworkError in
            XCTAssertEqual(NetworkError, noData)
            expectation.fulfill()
        }
        // Espero a que se cumplan las expectativas
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    
}
