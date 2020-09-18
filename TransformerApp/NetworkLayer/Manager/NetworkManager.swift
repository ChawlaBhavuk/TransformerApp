//
//  NetworkManager.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
typealias ServiceResponse<T> = (T?, String?) -> Void

protocol NetworkRouter: class {
    func getDataFromApi<T: Decodable>(type: T.Type, call: ApiCall,
                                      postData: [String: Any]?, completion: @escaping ServiceResponse<T>)
}

class NetworkManager: NetworkRouter {

    /// for getting data from api
    /// - Parameters:
    ///   - type: Model type
    ///   - call: Api Call Type
    ///   - completion: Sending Result
    func getDataFromApi<T: Decodable>(type: T.Type, call: ApiCall,
                                      postData: [String: Any]?, completion: @escaping ServiceResponse<T>) {
//        KeychainWrapper.standard.removeAllKeys()
        guard let endpoint = createEndPoint(call: call, postData: postData) else {
            return
        }
        var request = URLRequest(url: endpoint.baseURL)
        for headers in endpoint.headers {
            request.setValue(headers.value, forHTTPHeaderField: headers.key)
        }
        request.httpBody = endpoint.params
        request.httpMethod = endpoint.httpMethod.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, errors) in
            if self.getToken() == nil {
                self.saveToken(type: type.self, data: data, call: call, postData: postData, completion: completion)
            } else {
                do {
                    let jsonObject = try JSONDecoder().decode(T.self, from: data!)
                    completion(jsonObject, nil)
                } catch let error {
                    completion(nil, nil)
                    print(errors?.localizedDescription as Any)
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
                                         call: ApiCall, postData: [String: Any]?,
                                         completion: @escaping ServiceResponse<T>) {
        guard let data = data,
            let token = String(data: data, encoding: .utf8) else {
                self.getDataFromApi(type: type.self, call: .getToken, postData: postData, completion: completion)
                return
        }
        KeychainWrapper.standard.set(token, forKey: AppStrings.token)
        self.getDataFromApi(type: type.self, call: call, postData: postData, completion: completion)
    }

    /// creating  Endpoint
    ///
    /// - Parameters:
    ///   - call: Api Call Type
    /// - Returns: returning value of end point
   private  func createEndPoint(call: ApiCall, postData: [String: Any]?) -> EndPointType? {
        if let token = self.getToken() {
            switch call {
            case .getData:
                return self.commonEndPoint(token: token, httpMethod: .get, postData: postData)
            case .addData:
                return self.commonEndPoint(token: token, httpMethod: .post, postData: postData)
            case .deleteData:
                return self.commonEndPoint(token: token, httpMethod: .delete, postData: postData)
            case .editData:
                return self.commonEndPoint(token: token, httpMethod: .put, postData: postData)

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
    private func commonEndPoint(token: String, httpMethod: HTTPMethod, postData: [String: Any]?) -> EndPointType? {
        var endpoint = APIEndPoint.baseUrl + APIEndPoint.transformers
        if httpMethod == .delete,
            let id = postData?[CustomTransformer.SerializationKeys.id] as? String {
            endpoint += "/" + id
        }
        guard let url = URL(string: endpoint) else {
           return nil
        }
        var headers = [String: String]()
        headers[AppStrings.Headers.authorization] = AppStrings.Headers.bearer + " " + token
        headers[AppStrings.Headers.contentType] = AppStrings.Headers.applicationJson
        let endPoint = EndPointType(baseURL: url, headers: headers, httpMethod: httpMethod, params: postData)
        return endPoint
    }

    /// Fetch token from keychain
    /// - Returns:Authorization token
    private func getToken() -> String? {
        return KeychainWrapper.standard.string(forKey: AppStrings.token)
    }
}
