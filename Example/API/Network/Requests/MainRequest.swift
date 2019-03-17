//
//  MainRequest.swift
//  Example
//
//  Created by Yulia Moskaleva on 15/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation

import Alamofire

enum MainRequest: URLRequestConvertible {
    case listWithData()
    
    var method: HTTPMethod {
        switch self {
        case .listWithData:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .listWithData:
            return "/tmp/JSONSample.json"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Api.host.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        return request
    }
    
    
}

