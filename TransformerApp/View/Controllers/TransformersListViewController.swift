//
//  ViewController.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit

class TransformersListViewController: UIViewController {

    var reloadSections: ((_ section: Int) -> Void)?
    var items = [TransformerListViewModelItem]()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellClass: TranformersTableViewCell.self)
            tableView.registerHeader(headerClass: TransformerHeaderView.self)
        }
    }

    var networkManager: NetworkRouter = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getDataFromApi(type: WelcomeTransformers.self, call: .getData) {
                                        [weak self] jsonData, _  in
            if jsonData.transformers.count > 0 {
                let autobotsArray = jsonData.transformers.filter { $0.team == "A" }
                let decepticonsArray = jsonData.transformers.filter { $0.team == "D" }
                self?.items.append(TransformerViewModelAutobotsItem(transformers: autobotsArray))
                self?.items.append(TransformerViewModelDecepticonsItem(transformers: decepticonsArray))
            } else {

            }
//            self?.transformers = WelcomeTransformers.getFormat(transformers: jsonData.transformers)
            print(WelcomeTransformers.getFormat(transformers: jsonData.transformers))
            self?.reloadTableView()
        }

        self.reloadSections = { [weak self] (section: Int) in
            self?.tableView?.beginUpdates()
            self?.tableView?.reloadSections([section], with: .fade)
            self?.tableView?.endUpdates()
        }
    }

    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension TransformersListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueHeader(headerClass: TransformerHeaderView.self)
        headerView.section = section
        headerView.item = items[section]
        headerView.delegate = self
        return headerView
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items[section].isCollapsed {
            return items[section].transformer.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TranformersTableViewCell = tableView.dequeue(cellClass:
            TranformersTableViewCell.self, forIndexPath: indexPath)
        cell.item = items[indexPath.section].transformer[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension TransformersListViewController: TransformerHeaderViewDelegate {
    func toggleSection(header: TransformerHeaderView, section: Int) {
            var item = items[section]
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
            header.setCollapsed(collapsed: collapsed)
            reloadSections?(section)
    }
}
