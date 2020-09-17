//
//  TransformerListViewModal.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 17/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation

class TransformerListViewModal: NSObject {

    // MARK: Callbacks
    var reloadData:(() -> Void)?
    var showLoader:(() -> Void)?
    var removeLoader:(() -> Void)?


    // MARK: Other members
    var items = [TransformerListViewModelItem]()
    var networkManager: NetworkRouter = NetworkManager()

    /// for calling first time check data exist in DB or not
    func fetchTransformers() {
        self.showLoader?()
         networkManager.getDataFromApi(type: WelcomeTransformers.self, call: .getData) {
                                                [weak self] jsonData, _  in
            self?.removeLoader?()
            if jsonData.transformers.count > 0 {
                let autobotsArray = jsonData.transformers.filter { $0.team == "A" }
                let decepticonsArray = jsonData.transformers.filter { $0.team == "D" }
                self?.items.append(TransformerViewModelAutobotsItem(transformers: autobotsArray))
                self?.items.append(TransformerViewModelDecepticonsItem(transformers: decepticonsArray))
                self?.reloadData?()
            } else {

            }
        }
    }

}
