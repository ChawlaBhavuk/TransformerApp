//
//  UITableView+Operations.swift
//  TransformerApp
//
//  Created by Bhavuk Chawla on 16/09/20.
//  Copyright © 2020 Bhavuk Chawla. All rights reserved.
//
import UIKit

extension UITableView {

    public func dequeue<T: UITableViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
           guard let cell = dequeueReusableCell(
               withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
                   fatalError(
                       "Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
           }
           return cell
       }

    public func dequeueHeader<T: UITableViewHeaderFooterView>(headerClass: T.Type) -> T {
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: headerClass.reuseIdentifier)
            as? T else {
                fatalError(
                    "Error: header with id: \(headerClass.reuseIdentifier) is not \(T.self)")
        }
        return header
    }

    public func register<T: UITableViewCell>(cellClass: T.Type) {
        let nib = UINib(nibName: String(describing: cellClass), bundle: nil)
        register(nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func registerHeader<T: UITableViewHeaderFooterView>(headerClass: T.Type) {
        let nib = UINib(nibName: String(describing: headerClass), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: headerClass.reuseIdentifier)
    }

    func resetBackgroundView() {
        self.backgroundView = nil
    }

    func setEmptyView(title: String, message: String) {
        if self.backgroundView == nil {
            let emptyView = UIView()
            self.backgroundView = emptyView
            emptyView.anchor(top: self.topAnchor, left: self.leftAnchor,
                             bottom: self.bottomAnchor, right: self.rightAnchor,
                             paddingTop: AppConstant.zero, paddingLeft: AppConstant.zero,
                             paddingBottom: AppConstant.zero, paddingRight: AppConstant.zero,
                             width: self.frame.width, height: self.frame.height,
                             enableInsets: false)

            let titleLabel = UILabel()
            let messageLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont.boldSystemFont(ofSize: AppConstant.fontSize)
            messageLabel.textColor = UIColor.lightGray
            messageLabel.font = UIFont.systemFont(ofSize: AppConstant.fontSize)
            emptyView.addSubview(titleLabel)
            emptyView.addSubview(messageLabel)
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor,
                                                constant: -AppConstant.extraLargePadding).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true

            messageLabel.anchor(top: titleLabel.topAnchor, left: emptyView.leftAnchor,
                                bottom: nil, right: emptyView.rightAnchor,
                                paddingTop: AppConstant.extraLargePadding,
                                paddingLeft: AppConstant.commonPadding,
                                paddingBottom: AppConstant.commonPadding,
                                paddingRight: AppConstant.commonPadding,
                                width: AppConstant.zero, height: AppConstant.zero,
                                enableInsets: false)

            titleLabel.text = title
            messageLabel.text = message
            messageLabel.numberOfLines = AppConstant.numberOfLines
            messageLabel.textAlignment = .center
        }
    }
}
