//
//  TestHeroModel.swift
//  AppPatronesDiegoTests
//
//  Created by Macbook Pro on 27/1/24.
//

import XCTest

final class TestModel: XCTestCase {
    
    func test_HeroModel_Domain() async throws {
        let model = HeroModel(id: "1", name: "goku", description: "des", photo: "url", favorite: true)
        XCTAssertNotNil(model)
        XCTAssertEqual(model.name, "goku")
        XCTAssertEqual(model.favorite, true)
    }
    
    func test_DetailModel_Domain() async throws {
        let model = DetailModel(id: "2", name: "vegeta", description: "des", photo: "url", favorite: false)
        XCTAssertNotNil(model)
        XCTAssertEqual(model.id, "2")
        XCTAssertEqual(model.name, "vegeta")
        XCTAssertEqual(model.favorite, false)
    }
   
}
