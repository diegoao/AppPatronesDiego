//
//  HeroModel.swift
//  AppPatronesDiegoAndrades
//
//  Created by Macbook Pro on 25/1/24.
//

import Foundation

struct HeroModel: Decodable, Hashable {
    let id: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool
}
