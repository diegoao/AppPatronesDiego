//
//  HomeUseCase.swift
//  AppPatronesDiego
//
//  Created by Macbook Pro on 26/1/24.
//

import Foundation

//MARK: - PROTOCOLO HOME
protocol HomeUseCaseProtocol{
    func getHeroes(onSucess: @escaping([HeroModel])-> Void, onError: @escaping(NetworkError)-> Void)
}

//MARK: - CLASE HOMEUSECASE QUE CONFORMA el protocolo de arriba
final class HomeUseCase: HomeUseCaseProtocol {
    
    func getHeroes(onSucess: @escaping([HeroModel])-> Void, onError: @escaping(NetworkError)-> Void){
        
        //Comprobar URL
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.allHeros.rawValue)") else {
            onError(.malformedURL)
            return
        }
        //Check token
        guard let token = UserDefaultsHelper.getToken() else {
            onError(.tokenFormatError)
            return
        }
        //Crear Request
        //TODO: .Obtener el token de algun lado
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Bearer \(token) ", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(HTTPMethods.contentType, forHTTPHeaderField: "Content-Type")
        
        //Body
        struct HeroRequest: Encodable {
            let name: String
        }
        
        let heroRequest = HeroRequest(name: "")
        urlRequest.httpBody = try? JSONEncoder().encode(heroRequest)
        
        //TASK
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            //Check Error
            guard error == nil else{
                onError(.other)
                return
            }
            //Chek data
            guard let data = data else {
                onError(.noData)
                return
            }
            //Chek response
            guard let httresponse = (response as? HTTPURLResponse),
                  httresponse.statusCode == HTTPResponseCodes.SUCCESS else {
                onError(.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            guard var heroResponse = try? JSONDecoder().decode([HeroModel].self, from: data) else {
                onError(.decoding)
                return
            }
            // Borro el último heroe de la API ya que no pertenece a DragonBall (Daisy Johnson)
            if !heroResponse.isEmpty{
                heroResponse.removeLast()
            }
            onSucess(heroResponse)
        }
        task.resume()
    }
}


//MARK: - Fake Success
final class HomeUseCaseFakeSuccess: HomeUseCaseProtocol {
    func getHeroes(onSucess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let heroes = [HeroModel(id: "1", name: "Clark Kent", description: "Superman", photo: "", favorite: true),
                          HeroModel(id: "2", name: "Peter Parker", description: "Spiderman", photo: "", favorite: false),
                          HeroModel(id: "3", name: "Tony Stark", description: "IronMan", photo: "", favorite: false)]
            onSucess(heroes)
        }
    }
}
    
final class HomeUseCaseFakeError: HomeUseCaseProtocol {
        func getHeroes(onSucess: @escaping ([HeroModel]) -> Void, onError: @escaping (NetworkError) -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                onError(.noData)
        }
    }

}
