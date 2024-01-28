//
//  DetailUseCase.swift
//  AppPatronesDiego
//
//  Created by Macbook Pro on 26/1/24.
//

import Foundation

protocol DetailUseCaseProtocol{
    
    func getDetail(
        onSucess: @escaping([DetailModel]) -> Void,
        onError: @escaping(NetworkError) -> Void)
    
    func nameHero(name: String)
}

final class DetailUseCase: DetailUseCaseProtocol {
    
    var nameHero: String = ""
    
    init(nameHero: String = "") {
        self.nameHero = nameHero
    }
    
    func nameHero(name: String){
        self.nameHero = name
        return
    }
    
    func getDetail(
        onSucess: @escaping([DetailModel]) -> Void,
        onError: @escaping(NetworkError) -> Void){
            
        // Comprobar la url
            guard let url = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.allHeros.rawValue)") else {
                onError(.malformedURL)
                return
            }
            
        //check token
            guard let token = UserDefaultsHelper.getToken() else {
                onError(.tokenFormatError)
                return
            }
            
        // Crear request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Bearer \(token) ", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(HTTPMethods.contentType, forHTTPHeaderField: "Content-Type")
            
        //Cuerpo
        struct DetailHeroRequest: Encodable {
            let name : String
        }
        
        let heroRequest = DetailHeroRequest(name: nameHero )
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
            guard let heroResponse = try? JSONDecoder().decode([DetailModel].self, from: data) else {
                onError(.decoding)
                return
            }
            onSucess(heroResponse)
        }
        task.resume()
    }
}


//MARK: - Fake Success
final class DetailUseCaseFakeSuccess: DetailUseCaseProtocol {
    func getDetail(onSucess: @escaping ([DetailModel]) -> Void, onError: @escaping (NetworkError) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let heroe = [DetailModel(id: "1", name: "Goku", description: "Strong", photo: "", favorite: true)]
            onSucess(heroe)
        }
    }
    
    func nameHero(name: String) {
        return
    }
}
   
//MARK: - Fake Error
final class DetailUseCaseFakeError: DetailUseCaseProtocol {
    func getDetail(onSucess: @escaping ([DetailModel]) -> Void, onError: @escaping (NetworkError) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            onError(.malformedURL)
        }
    }
    
    func nameHero(name: String) {
        return
    }
}

