//
//  RequestManager.swift
//  Example
//
//  Created by Yulia Moskaleva on 13/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Alamofire

final class RequestManager {
    static let shared = RequestManager()
    
    private lazy var sessionManager: SessionManager = {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        let manager = SessionManager(
            configuration: URLSessionConfiguration.default
        )
        
        
        return manager
    }()
    
    private init() { }
    
    
    
    public func execute<T: URLRequestConvertible, TResult: Codable>(
        _ request: T,
        on finish: @escaping (TResult?, Error?) -> Void)
    {
        execute(request) { (response, error) in
            guard let data = response?.data else {
                finish(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let result = try jsonDecoder.decode(TResult.self, from: data)
                finish(result, error)
            } catch {
                finish(nil, error)
            }
        }
    }
    
    public func execute<T: URLRequestConvertible>(
        _ request: T,
        on finish: @escaping (DataResponse<Data>?, Error?) -> Void)
    {
        execute(sessionManager.request(request), on: finish)
    }
    
    public func execute(
        _ request: DataRequest,
        on finish: @escaping(DataResponse<Data>?, Error?) -> Void)
    {
        print("Request: \(request)")
        request
            .validate(statusCode: 200..<300)
            .responseData(completionHandler: { (response) in
                print("Response: \(response)")
                if let _ = response.error {
                    finish(nil, ApiError(response))
                    return
                }
                finish(response, nil)
            })
    }
    
    public func cancelAllTasks(on finish: @escaping () -> Void) {
        sessionManager.session.getAllTasks { (tasks) in
            tasks.forEach { $0.cancel() }
            finish()
        }
    }
}

public struct ApiError: LocalizedError {
    let code: Int
    let message: String?
    
    init(_ response: DataResponse<Data>) {
        code = response.response?.statusCode ?? 0
        
        if let data = response.data,
            let json = try? JSONSerialization.jsonObject(with: data)
        {
            switch json {
            case let body as [String: String]:
                message = body["error_description"]
            case let body as [String: [String]]:
                message = body.first?.value.first
            default:
                message = ""
            }
        } else {
            message = response.error?.localizedDescription
        }
    }
    
    public var errorDescription: String? {
        return message ?? ""
    }
    
    public var localizedDescription: String {
        return message ?? ""
    }
}


