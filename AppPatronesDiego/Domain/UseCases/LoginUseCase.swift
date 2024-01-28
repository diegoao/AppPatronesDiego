//
//  LoginUseCase.swift
//  AppPatronesDiego
//
//  Created by Macbook Pro on 26/1/24.
//

import Foundation

//MARK: - PROTOCOLO LOGIN USE CASE
protocol LoginUseCaseProtocol{
    func login(user: String,
               password: String,
               onSucces: @escaping (String?) -> Void,
               onError: @escaping (NetworkError) -> Void)
}



//MARK: - Clase Login Use Case
final class LoginUseCase: LoginUseCaseProtocol {
    
    func login(user: String,
               password: String,
               onSucces: @escaping (String?) -> Void,
               onError: @escaping (NetworkError) -> Void)
    {
        //Comprobar URL
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.login.rawValue)") else {
            onError(.malformedURL)
            return
        }
        
        //Codificar datos
        //user:password
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            onError(.dataFormatting)
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        //Crear REQUEST
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        //DataTask
        let task = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            //Check error
            guard error == nil else {
                onError(.other)
                return
            }
            
            //Check Data
            guard let data = data else {
                onError(.noData)
                return
            }
            
            //Check respuesta
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == HTTPResponseCodes.SUCCESS else {
                onError(.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            //Transformar el dato para tener el token
            guard let token = String(data: data, encoding: .utf8) else {
                onError(.tokenFormatError)
                return
            }
            UserDefaultsHelper.save(token: token)
            onSucces(token)
        }
        task.resume()
        
    }
}



//MARK: - LOGIN USE CASE FAKE SUCCESS
final class LoginUseCaseFakeSuccess: LoginUseCaseProtocol{
    func login(user: String, password: String, onSucces: @escaping (String?) -> Void, onError: @escaping (NetworkError) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            let token = "123456789123456789"
            onSucces(token)
        }
    }
    
    
}

//MARK: - LOGIN USE CASE FAKE ERROR
final class LoginUseCaseFakeError: LoginUseCaseProtocol{
    func login(user: String, password: String, onSucces: @escaping (String?) -> Void, onError: @escaping (NetworkError) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            onError(.noData)
        }
    }
}
