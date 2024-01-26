//
//  LoginStatusLoad.swift
//  AppPatronesDiegoAndrades
//
//  Created by Macbook Pro on 25/1/24.
//
import Foundation

enum LoginStatusLoad {
    case loading(_ isLoading: Bool)
    case loaded
    case showErrorEmail(_ error: String?)
    case showErrorPassword(_ error: String?)
    case errorNetwork(_ error: String)
}
