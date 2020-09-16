//
//  NetworkManager.swift
//  DeliveryApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
typealias ServiceResponse<T> = (T, String?) -> Void

enum NetworkResponse: String {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

protocol NetworkRouter: class {
    func getDataFromApi<T: Decodable>(type: T.Type, call: ApiCall, completion: @escaping ServiceResponse<T>)
}

class  NetworkManager: NetworkRouter {



    /// for getting data from api
    /// - Parameters:
    ///   - type: Model type
    ///   - call: Api Call Type
    ///   - completion: Sending Result
    func getDataFromApi<T: Decodable>(type: T.Type, call: ApiCall, completion: @escaping ServiceResponse<T>) {
//        KeychainWrapper.standard.removeAllKeys()
        guard let endpoint = createEndPoint(call: call) else {
            return
        }
        var request = URLRequest(url: endpoint.baseURL)
        for headers in endpoint.headers {
            request.setValue(headers.value, forHTTPHeaderField: headers.key)
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if self.getToken() == nil {
                self.saveToken(type: type.self, data: data, call: call, completion: completion)
            } else {
                do {
                    let jsonObject = try JSONDecoder().decode(T.self, from: data!)
                    completion(jsonObject, nil)
                } catch let error {
                    print(error.localizedDescription)
                }
            }

        }.resume()
    }


    /// For save token in keychain
    /// - Parameters:
    ///   - type: Model type
    ///   - data: data type
    ///   - call: Api Call Type
    ///   - completion: Sending Result
    private func saveToken<T: Decodable>(type: T.Type, data: Data?,
                                 call: ApiCall, completion: @escaping ServiceResponse<T>) {
        guard let data = data,
            let token = String(data: data, encoding: .utf8) else {
                self.getDataFromApi(type: type.self, call: .getToken, completion: completion)
                return
        }
        KeychainWrapper.standard.set(token, forKey: AppStrings.token)
        self.getDataFromApi(type: type.self, call: call, completion: completion)
    }

    /// error code messages
    ///
    /// - Parameter statusCode: status code value
    /// - Returns: error message
    fileprivate func handleNetworkResponse(_ statusCode: Int) -> String {
        switch statusCode {
        case 401...500: return NetworkResponse.authenticationError.rawValue
        case 501...599: return NetworkResponse.badRequest.rawValue
        case 600: return NetworkResponse.outdated.rawValue
        default: return NetworkResponse.failed.rawValue
        }
    }

    /// creating  Endpoint
    ///
    /// - Parameters:
    ///   - call: Api Call Type
    /// - Returns: returning value of end point
   private  func createEndPoint(call: ApiCall) -> EndPointType? {
        if let token = self.getToken() {
            switch call {
            case .getData:
                return self.commonEndPoint(token: token, httpMethod: .get)
            default:
                 return nil
            }
        } else {
            let endpoint = APIEndPoint.baseUrl + APIEndPoint.allspark
            guard let url = URL(string: endpoint) else {
                return nil
            }
            let endPoint = EndPointType(baseURL: url, headers: [:], httpMethod: .get)
            return endPoint
        }

    }


    /// Common end point for network calls
    /// - Parameters:
    ///   - token: Authorization token
    ///   - httpMethod: Request type
    /// - Returns: End point of call
    private func commonEndPoint(token: String, httpMethod: HTTPMethod) -> EndPointType? {
        let endpoint = APIEndPoint.baseUrl + APIEndPoint.transformers
        guard let url = URL(string: endpoint) else {
           return nil
        }
        var headers = [String: String]()
        headers[AppStrings.Headers.authorization] = AppStrings.Headers.bearer + " " + token
        headers[AppStrings.Headers.contentType] = AppStrings.Headers.applicationJson
        let endPoint = EndPointType(baseURL: url, headers: headers, httpMethod: .get)
        return endPoint
    }


    /// Fetch token from keychain
    /// - Returns:Authorization token
    private func getToken() -> String? {
        return KeychainWrapper.standard.string(forKey: AppStrings.token)
    }
}