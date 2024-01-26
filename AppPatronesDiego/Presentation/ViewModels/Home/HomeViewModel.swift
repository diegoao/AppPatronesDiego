//
//  HomeViewModel.swift
//  AppPatronesDiegoAndrades
//
//  Created by Macbook Pro on 23/1/24.
//

import Foundation

final class HomeViewModel {
    
    //binding con UI
    var homeStatusLoad: ((SplashStatusLoad)-> Void)?
    
    
    //caseUse
    let homeUseCase: HomeUseCaseProtocol
    var dataHeroes: [HeroModel] = []
    
    //init
    init(homeUseCase: HomeUseCaseProtocol = HomeUseCase()){
        self.homeUseCase = homeUseCase
    }
    
    //Llamada a getHeroes
    func loadHeros() {
        homeStatusLoad?(.loading)
        
        homeUseCase.getHeroes { [weak self] heroes in
            DispatchQueue.main.async {
                self?.dataHeroes = heroes
                self?.homeStatusLoad?(.loaded)
            }
            
        } onError: { [weak self] networkError in
            DispatchQueue.main.async {
                self?.homeStatusLoad?(.error)
                
            }
        }
    }
}
