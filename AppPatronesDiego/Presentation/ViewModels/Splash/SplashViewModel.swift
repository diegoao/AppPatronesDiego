//
//  SplashViewModel.swift
//  DragonBallMVVM
//
//  Created by Aitor Iglesias Pubill on 22/1/24.
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

