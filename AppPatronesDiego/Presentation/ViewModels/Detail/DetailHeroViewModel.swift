//
//  DetailHeroViewModel.swift
//  AppPatronesDiegoAndrades
//
//  Created by Macbook Pro on 25/1/24.
//

import Foundation


final class DetailHeroViewModel{
    
    //binding con UI
    var datailStatusLoad: ((SplashStatusLoad)-> Void)?
    
    
    //caseUse
    let detailUseCase: DetailUseCaseProtocol
    var detailData: [DetailModel] = []
    
    //inicializamos
    init(detailUseCase : DetailUseCaseProtocol = DetailUseCase()){
        self.detailUseCase = detailUseCase
    }
    
    // Llamada a getDetail
    
    func loadDetail(heroname: String){
        datailStatusLoad?(.loading)
        detailUseCase.nameHero(name: heroname)
        detailUseCase.getDetail { [weak self] detail in
            DispatchQueue.main.async {
                self?.detailData = detail
                self?.datailStatusLoad?(.loaded)
            }
        } onError: {[weak self] NetworkError  in
            DispatchQueue.main.async {
                self?.datailStatusLoad?(.error)
            }
        }
    }
}
    
    
    
    
    
    
    
    
    
    
    
    

