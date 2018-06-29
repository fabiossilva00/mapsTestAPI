//
//  ComunicacoesAlamoFire.swift
//  mapsTestAPI
//
//  Created by Fabio Sousa da Silva on 29/06/2018.
//  Copyright © 2018 br.com.mapsTestAPI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ComunicacoesAlamoFire: NSObject {

    func markePost(titulo: String, latitude: Double, longitude: Double, imagem: String, descricao: String, completion: @escaping (_ error: Bool, _ id: String) -> Void){
        
        guard let urlRequest = URL(string: "http://192.168.15.11:3010/post") else { return }
        
        let parameters: Parameters=["titulo": titulo, "latitude": latitude, "longitude": longitude, "imagem": imagem, "descricao": descricao]
        
        Alamofire.request(urlRequest, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON() { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                if let respostaAPI = response.result.value as? [String: Any] {
                    let json = respostaAPI as NSDictionary
                    let swiftyJSON = JSON(json)
                    let id = swiftyJSON["_id"].stringValue
                    completion(false, id)
                }
                
                break
            case .failure:
                completion(true, "")
                break
                
            }
            
        }
        
    }
    
    func markerGet(completion: @escaping (_ id: Array<String>, _ descricao: Array<String>, _ imagem: Array<String>, _ latitude: Array<Double>, _ longitude: Array<Double> ) -> Void){
        
        guard let urlRequest = URL(string: "http://192.168.15.11:3010/teste") else { return }
        
        Alamofire.request(urlRequest).validate().responseJSON() { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                var idArray: Array<String> = []
                var descricaoArray: Array<String> = []
                var imagemArray: Array<String> = []
                var latitudeArray: Array<Double> = []
                var longitudeArray: Array<Double> = []
                
                do {
                    let swiftyJSON = try JSON(data: response.data!)
//                    print(swiftyJSON.count)
                    for sJSON in swiftyJSON {
                        
                        idArray.append(sJSON.1["_id"].stringValue)
                        descricaoArray.append(sJSON.1["descricao"].stringValue)
                        imagemArray.append(sJSON.1["imagem"].stringValue)
                        latitudeArray.append(sJSON.1["latitude"].doubleValue)
                        longitudeArray.append(sJSON.1["longitude"].doubleValue)
                        
                    }
                    completion(idArray, descricaoArray, imagemArray, latitudeArray, longitudeArray)
                } catch {
                    print(error.localizedDescription)
                }
                
                
                break
            case .failure:
                
                break
                
            }
            
        }
        
    }
    
}
