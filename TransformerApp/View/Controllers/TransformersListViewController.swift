//
//  ViewController.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//

import UIKit
import SVProgressHUD

class TransformersListViewController: UIViewController {

    var reloadSections: ((_ section: Int) -> Void)?
    var viewModel = TransformerListViewModal()

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

        self.navigationItem.title = AppLocalization.tranformers
        self.responseHandlerFromViewModal()
        self.setupUI()
        viewModel.fetchTransformers()
    }

    func setupUI() {
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

    // MARK: Data handler from view model

    /// handling responses from view model
   func responseHandlerFromViewModal() {

       self.viewModel.showLoader = {
           SVProgressHUD.show(withStatus: AppLocalization.loading)
       }

       self.viewModel.removeLoader = {
           SVProgressHUD.dismiss()
       }

       viewModel.reloadData = { [weak self] in
           DispatchQueue.main.async {
               self?.tableView.resetBackgroundView()
               self?.tableView.reloadData()
           }
       }
   }

}

extension TransformersListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueHeader(headerClass: TransformerHeaderView.self)
        headerView.section = section
        headerView.item = viewModel.items[section]
        headerView.delegate = self
        return headerView
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.items[section].isCollapsed {
            return viewModel.items[section].transformer.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TranformersTableViewCell = tableView.dequeue(cellClass:
            TranformersTableViewCell.self, forIndexPath: indexPath)
        cell.item = viewModel.items[indexPath.section].transformer[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension TransformersListViewController: TransformerHeaderViewDelegate {
    func toggleSection(header: TransformerHeaderView, section: Int) {
        var item = viewModel.items[section]
        let collapsed = !item.isCollapsed
        item.isCollapsed = collapsed
        header.setCollapsed(collapsed: collapsed)
        reloadSections?(section)
    }
}
