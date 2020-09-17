//
//  TransformerListViewModal.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 17/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class TransformerListViewModal: NSObject {

    // MARK: Callbacks
    var reloadData:(() -> Void)?
    var showLoader:(() -> Void)?
    var removeLoader:(() -> Void)?
    var reloadSections: ((_ section: Int) -> Void)?
    var reloadDataWithEmptyMessage:(() -> Void)?

    // MARK: Other members
    var items = [TransformerListViewModelItem]()
    var networkManager: NetworkRouter = NetworkManager()

    /// for fetch transformers
    func fetchTransformers() {
        self.showLoader?()
        networkManager.getDataFromApi(type: WelcomeTransformers.self,
                                      call: .getData, postData: nil) { [weak self] (jsonData, _)  in
            self?.removeLoader?()
            self?.items.removeAll()
            guard let jsonData = jsonData, jsonData.transformers.count > 0 else {
                self?.reloadDataWithEmptyMessage?()
                return
            }
            let autobotsArray = jsonData.transformers.filter { $0.team == "A" }
            let decepticonsArray = jsonData.transformers.filter { $0.team == "D" }
            if autobotsArray.count > 0 {
                self?.items.append(TransformerViewModelAutobotsItem(transformers:
                autobotsArray))
            }
            if decepticonsArray.count > 0 {
                self?.items.append(TransformerViewModelDecepticonsItem(transformers:
                decepticonsArray))
            }
            self?.reloadData?()
        }
    }

    /// For delete Transformer
    /// - Parameter id: Transformer's Id
    func deleteTransformer(id: String) {
        self.showLoader?()
        networkManager.getDataFromApi(type: EmptyModel.self, call: .deleteData,
                                      postData: [CustomTransformer.SerializationKeys.id: id]) { [weak self] (_, _)  in
        self?.fetchTransformers()
        }
    }

    /// Clear Token and get new token
    func clearSession() {
        KeychainWrapper.standard.removeAllKeys()
        self.fetchTransformers()
    }

}
