//
//  NetworkManager.swift
//  straiberry
//
//  Created by Behnam on 20.06.22.
//

import Foundation
import Alamofire

// FIXME: - Refactor, you can use function generally not just for one endpoint !

public class NetworkManager {
    
    
    public typealias NetworkManagerCallback = (Data) -> Void
    public typealias NetworkManagerFallback = (String) -> Void
    
    static let shared = NetworkManager()
    private init() {}

    func call(type: EndpointRoute, params: Parameters? = nil, callback: @escaping NetworkManagerCallback,
              fallback: @escaping NetworkManagerFallback) {
        
        var params=params ?? [:]
        for (key, value) in type.params{
            params[key]=value
        }
        print("✈️ call params")
        print("url: \(type.url)")
        print("method: \(type.method)")
        print("params: \(params)")
        print("enconding: \(type.encoding)")
        print("headers: \(type.headers)\n")
        
        
        
        AF.request(type.url, method: type.method, parameters: params, encoding: type.encoding, headers: type.headers).response { response in
            switch response.result {
            case .success(let json):
                print("\(response.response?.statusCode)")
                if(response.response?.statusCode ?? 200 >= 200 && response.response?.statusCode ?? 200 < 300 || response.response?.statusCode ==  400 ){
                    if let json=json{
                            callback(json)
                        }
                    else{
                        fallback("invalid data")
                    }
                }
                else{
                    print("❌ Alamofire, Response code is not 200 ❌")
                    print("Response code :\(response.response?.statusCode)")
                    if let code = response.response?.statusCode{
                        fallback("invalid respnse code:\(code)")
                    }
                    else
                    {
                        fallback("invalid respnse code")
                    }
                }
                
            case .failure(let error):
                
                print("❌ Alamofire, call failure ❌")
                print(error)
                fallback(error.errorDescription ?? "an error happend")
            }
        }
        
        print("\n")
    }
    
    
    
}
