//
//  SplashViewModel.swift
//  AppPatronesDiegoAndrades
//
//  Created by Macbook Pro on 25/1/24.
//

import Foundation

final class SplashViewModel {
    
    //binding con UI
    var modelStatusLoad: ((SplashStatusLoad) -> Void)?
    
    //Funcion Simular Carga Datos
    func simulationLoadData() {
        //Variable estado --> ESTOY CARGANDO
        modelStatusLoad?(.loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            //Variable estado --> YA ME HE CARGADO
            self?.modelStatusLoad?(.loaded)
        }
    }
}

