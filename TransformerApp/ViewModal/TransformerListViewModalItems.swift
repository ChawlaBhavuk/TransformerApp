//
//  TransformerListViewModal.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import Foundation

enum Team: Int {
    case autobots = 0
    case decepticons = 1
}

protocol TransformerListViewModelItem {
    var type: Team { get }
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

    var type: Team {
        return .autobots
    }

    var sectionTitle: String {
        return AppLocalization.Teams.autobots
    }

    var isCollapsed = true

    var transformers: [Transformer]
    var selectedTransformers = [Transformer]()

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

    var type: Team {
        return .decepticons
    }

    var sectionTitle: String {
        return AppLocalization.Teams.decepticons
    }

    var isCollapsed = true

    var transformers: [Transformer]
    var selectedTransformers = [Transformer]()

    init(transformers: [Transformer]) {
       self.transformers = transformers
    }

}
