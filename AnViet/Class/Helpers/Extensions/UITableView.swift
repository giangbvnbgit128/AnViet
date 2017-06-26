//
//  UITableView.swift
//  TLSafone
//
//  Created by Nguyen Van Hoa on 3/7/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import UIKit

public extension UITableView {
    /**
     Registers a UITableViewCell for use in a UITableView.

     - parameter type: The type of cell to register.
     - parameter reuseIdentifier: The reuse identifier for the cell (optional).

     By default, the class name of the cell is used as the reuse identifier.

     Example:
     ```
     class CustomCell: UITableViewCell {}

     let tableView = UITableView()

     // registers the CustomCell class with a reuse identifier of "CustomCell"
     tableView.registerCell(CustomCell)
     ```
     */
    func registerCellClass<T: UITableViewCell>(_ aClass: T.Type) {
        let identifier = aClass.className
        self.register(aClass.self, forCellReuseIdentifier: identifier)
    }

    func registerCellNib<T: UITableViewCell>(_ aClass: T.Type) {
        let identifier = aClass.className
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }

    func registerHeaderFooterViewClass<T: UIView>(_ viewClass: T.Type) {
        let identifier = viewClass.className
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func registerHeaderFooterViewNib<T: UIView>(_ viewClass: T.Type) {
        let identifier = viewClass.className
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func dequeue<T: UITableViewCell>(_ aClass: T.Type) -> T {
        return (dequeueReusableCell(withIdentifier: aClass.className) as? T)!
    }

    func dequeue<T: UITableViewHeaderFooterView>(_ aClass: T.Type) -> T {
        return (dequeueReusableHeaderFooterView(withIdentifier: aClass.className) as? T)!
    }

    func setSeparatorInsets(_ insets: UIEdgeInsets) {
        separatorInset = insets
        layoutMargins = insets
    }


    /**
    Inserts rows into self.

    - parameter indices: The rows indices to insert into self.
    - parameter section: The section in which to insert the rows (optional, defaults to 0).
    - parameter animation: The animation to use for the row insertion (optional, defaults to `.Automatic`).
    */
    public func insert(_ indices: [Int], section: Int = 0, animation: UITableViewRowAnimation = .automatic) {
        let indexPaths = indices.map { IndexPath(row: $0, section: section) }

        beginUpdates()
        insertRows(at: indexPaths, with: animation)
        endUpdates()
    }

    /**
     Deletes rows from self.

     - parameter indices: The rows indices to delete from self.
     - parameter section: The section in which to delete the rows (optional, defaults to 0).
     - parameter animation: The animation to use for the row deletion (optional, defaults to `.Automatic`).
     */
    public func delete(_ indices: [Int], section: Int = 0, animation: UITableViewRowAnimation = .automatic) {
        let indexPaths = indices.map { IndexPath(row: $0, section: section) }

        beginUpdates()
        deleteRows(at: indexPaths, with: animation)
        endUpdates()
    }

    /**
     Reloads rows in self.

     - parameter indices: The rows indices to reload in self.
     - parameter section: The section in which to reload the rows (optional, defaults to 0).
     - parameter animation: The animation to use for reloading the rows (optional, defaults to `.Automatic`).
     */
    public func reload(_ indices: [Int], section: Int = 0, animation: UITableViewRowAnimation = .automatic) {
        let indexPaths = indices.map { IndexPath(row: $0, section: section) }

        beginUpdates()
        reloadRows(at: indexPaths, with: animation)
        endUpdates()
    }

    func scrollToBottomAnimated(_ animated: Bool) {
        let row = numberOfRows(inSection: 0) - 1
        if row >= 0 {
            let indexPath = IndexPath(row: row, section: 0)
            scrollToIndexPath(indexPath, animated: animated)
        }
    }

    func scrollToIndexPath(_ indexPath: IndexPath, animated: Bool) {
        scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: animated)
    }

//Refresh and loadmore
}

extension UITableViewCell {
    public func setSeparatorInsets(_ insets: UIEdgeInsets) {
        separatorInset = insets
        layoutMargins = insets
    }
}
