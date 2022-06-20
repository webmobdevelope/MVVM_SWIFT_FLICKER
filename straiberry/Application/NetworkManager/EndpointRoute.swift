//
//  EndpointRoute.swift
//  straiberry
//
//  Created by Behnam on 20.06.22.
//

import Foundation
import Foundation
import Alamofire
public enum EndpointRoute: Equatable {
    case getPhotoList
}


extension EndpointRoute: EndpointOption {
    public static let DEVICE_TYPE="IOS"
    public var baseURL: String {
        switch self {
        /// Auth Server
        case .getPhotoList :
            return "https://api.flickr.com/"
        default:
            return "https://baseurl/"
        }
    }
    
    
    
    public var headers: HTTPHeaders {
        switch self {
        case .getPhotoList:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        
        default:
            return ["Content-Type": "application/json",
                    "auth":"" ]
        }
    }
    public var params: Parameters {
        switch self {
        case .getPhotoList:
            return ["method":"flickr.photos.search","api_key":"7ffc258852e3ae21a4eb516f4a829034","format":"json","nojsoncallback":"?"]
        
        default:
            return [:]
        }
    }
    
    
    public var method: HTTPMethod {
        switch self {
        case .getPhotoList :
            return .get
        default:
            return .post
        }
    }
    
    
    
    public var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    public var strurl: String {
        switch self {
        default:
            return self.baseURL + self.path
        }
    }


    public var encoding: ParameterEncoding {
        switch self {
        case .getPhotoList :
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }



    public var path: String {
        switch self {
        case .getPhotoList:
            return "services/rest/"
        }
    }
}
