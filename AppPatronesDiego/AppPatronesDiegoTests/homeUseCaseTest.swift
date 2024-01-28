//
//  homeUseCaseTest.swift
//  AppPatronesDiegoTests
//
//  Created by Macbook Pro on 28/1/24.
//

import XCTest
@testable import AppPatronesDiego

class HomeUseCaseTests: XCTestCase {
    
    func testHomeUseCaseFakeSuccess() {
        // Creo lista de héroes para comparar con la clase HomeUseCaseFakeSuccess
        let heroestest = [HeroModel(id: "1", name: "Clark Kent", description: "Superman", photo: "", favorite: true),
                          HeroModel(id: "2", name: "Peter Parker", description: "Spiderman", photo: "", favorite: false),
                          HeroModel(id: "3", name: "Tony Stark", description: "IronMan", photo: "", favorite: false)]
        
        
        // Configurar el objeto HomeUseCaseFakeSuccess
        let homeUseCaseFakeSuccess = HomeUseCaseFakeSuccess()
        
        // Configurar expectativas
        let expectation = expectation(description: "HomeUseCase Success")
        
        // Realizo la llamada a la función de getHeroes
        homeUseCaseFakeSuccess.getHeroes(onSucess: { heroes in
            XCTAssertEqual(heroes, heroestest)
            expectation.fulfill()
        }, onError: { error in
            XCTFail("Unexpected error: \(error)")
            expectation.fulfill()
        })
        
        // Espero a que se cumplan las expectativas
        wait(for: [expectation], timeout: 5.0)
    }
    


    func testHomeUseCaseFakeError() {
        // Configurar el objeto HomeUseCaseFakeError
        let homeUseCaseFakeError = HomeUseCaseFakeError()
        
        // Configurar expectativas
        let expectation = XCTestExpectation(description: "HomeUseCase completion error")

        // Realizo la llamada a la función de getHeroes
        homeUseCaseFakeError.getHeroes(onSucess: { heroes in
            XCTFail("Unexpected success")
            expectation.fulfill()
        }, onError: { error in
            XCTAssertEqual(error, NetworkError.noData)
            expectation.fulfill()
        })

        // Esperar a que se cumplan las expectativas
        wait(for: [expectation], timeout: 5.0)
    }
}
