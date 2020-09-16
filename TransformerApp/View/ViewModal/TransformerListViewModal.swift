//
//  TransformerListViewModal.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation

enum TransformerListViewModelItemType {
    case autobots
    case decepticons
}

protocol TransformerListViewModelItem {
    var type: TransformerListViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
    var isCollapsed: Bool { get set }
    var transformer: [Transformer] { get }
}

class TransformerViewModelAutobotsItem: TransformerListViewModelItem {

    var transformer: [Transformer] {
        return transformers
    }

    var rowCount: Int {
        return transformer.count
    }

    var type: TransformerListViewModelItemType {
        return .autobots
    }

    var sectionTitle: String {
        return AppStrings.Teams.autobots
    }

    var isCollapsed = true

    var transformers: [Transformer]

    init(transformers: [Transformer]) {
       self.transformers = transformers
    }

}

class TransformerViewModelDecepticonsItem: TransformerListViewModelItem {
    var transformer: [Transformer] {
        return transformers
    }

    var rowCount: Int {
        transformer.count
    }

    var type: TransformerListViewModelItemType {
        return .decepticons
    }

    var sectionTitle: String {
        return AppStrings.Teams.decepticons
    }

    var isCollapsed = true

    var transformers: [Transformer]

    init(transformers: [Transformer]) {
       self.transformers = transformers
    }

}
