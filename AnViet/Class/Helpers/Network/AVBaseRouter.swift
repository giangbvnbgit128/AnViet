//
//  AVBaseRouter.swift
//  AnViet
//
//  Created by Bui Giang on 5/25/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//
import UIKit
import Alamofire

public typealias JSONDictionary = [String: AnyObject]
typealias APIParams = [String : AnyObject]?

protocol APIConfiguration {
    var method: HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: APIParams { get }
    var baseUrl: String { get }
}

public let kBaseUrl = "BaseUrl"

class AVBaseRouter: URLRequestConvertible, APIConfiguration {
    var method: HTTPMethod {
        fatalError("\( #function )Must be overridden in subclass")
    }
    
    var encoding: Alamofire.ParameterEncoding? {
        fatalError("\( #function )Must be overridden in subclass")
    }
    
    var path: String {
        fatalError("\( #function )Must be overridden in subclass")
    }
    
    var parameters: APIParams {
        fatalError("\( #function )Must be overridden in subclass")
    }
    
    var baseUrl: String {
        return "http://anvietcomputer.com/"
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseUrl + path)!
        print("==== url = \(url)")
        do {
            let headers = ["Content-Type" : "application/json"]
            var urlrequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 600)
            urlrequest.allHTTPHeaderFields = headers
            if let encoding = encoding {
                try encoding.encode(urlrequest, with: parameters)
            }
            print("RequestUrl = \(urlrequest)")
            return urlrequest
        }
    }
    
}
