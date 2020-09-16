//
//  AppEndPoint.swift
//  DeliveryApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation

struct EndPointType {
    var baseURL: URL
    var headers: [String: String]
    var httpMethod: HTTPMethod

    init(baseURL: URL, headers: [String: String], httpMethod: HTTPMethod = .get) {
        self.baseURL = baseURL
        self.headers = headers
        self.httpMethod = httpMethod
    }
}

enum HTTPMethod {
    case get
    case put
    case post
}

struct APIEndPoint {
    static let baseUrl = "https://transformers-api.firebaseapp.com/"
    static let allspark = "allspark"
    static let transformers = "transformers"
}

enum ApiCall {
    case getToken
    case getData
}
