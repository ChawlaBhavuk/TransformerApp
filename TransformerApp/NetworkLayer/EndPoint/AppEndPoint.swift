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
    var params: Data?

    init(baseURL: URL, headers: [String: String], httpMethod: HTTPMethod = .get, params: [String: Any]? = nil) {
        self.baseURL = baseURL
        self.headers = headers
        self.httpMethod = httpMethod
        if let params = params {
            self.params = try? JSONSerialization.data(withJSONObject: params)
        } else {
            self.params = nil
        }

    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "Delete"
}

struct APIEndPoint {
    static let baseUrl = "https://transformers-api.firebaseapp.com/"
    static let allspark = "allspark"
    static let transformers = "transformers"
}

enum ApiCall {
    case getToken
    case getData
    case addData
    case deleteData
    case editData
}
