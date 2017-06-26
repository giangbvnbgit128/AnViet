//
//  UICollectionView.swift
//  TLSafone
//
//  Created by Nguyen Van Hoa on 3/7/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import UIKit

extension UICollectionView {

    public enum SectionType {
        case header
        case footer
        var kind: String {
            switch self {
            case .header: return UICollectionElementKindSectionHeader
            case .footer: return UICollectionElementKindSectionFooter
            }
        }
    }

    /**
     Registers a CustomCollectionViewCell for use in a UICollectionView.
     - parameter type: The type of cell to register.
     - parameter reuseIdentifier: The reuse identifier for the cell (optional).
     By default, the class name of the cell is used as the reuse identifier.

     Example:
     ```
     class CustomCell: CustomCollectionViewCell {}

     let collectionView = UICollectionView()

     // registers the CustomCell class with nibName is "CustomCell" a reuse identifier of "CustomCell"
     collectionView.registerNib(CustomCell)
     ```
     */
    public func registerNib<T: UICollectionViewCell>(_ aClass: T.Type) {
        let name = String.className(aClass)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellWithReuseIdentifier: name)
    }

    /**
     Registers a UICollectionViewCell for use in a UICollectionView.
     - parameter type: The type of cell to register.
     - parameter reuseIdentifier: The reuse identifier for the cell (optional).
     By default, the class name of the cell is used as the reuse identifier.

     Example:
     ```
     class DefaultCell: UICollectionViewCell {}

     let collectionView = UICollectionView()

     // registers the DefaultCell class  a reuse identifier of "CustomCell"
     collectionView.registerNib(CustomCell)
     ```
     */
    public func registerClass<T: UICollectionViewCell>(_ aClass: T.Type) {
        let name = String.className(aClass)
        register(aClass, forCellWithReuseIdentifier: name)
    }

    public func registerNib<T: UICollectionReusableView>(_ aClass: T.Type, type: SectionType) {
        let name = String.className(aClass)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forSupplementaryViewOfKind: type.kind, withReuseIdentifier: name)
    }

    public func registerClass<T: UICollectionReusableView>(_ aClass: T.Type, type: SectionType) {
        let name = String.className(aClass)
        register(aClass, forSupplementaryViewOfKind: type.kind, withReuseIdentifier: name)
    }

    /**
    Registers a UICollectionReusableView for use in a UICollectionView section header.
    - parameter type: The type of header view to register.
    - parameter reuseIdentifier: The reuse identifier for the header view (optional).
    By default, the class name of the header view is used as the reuse identifier.

    Example:
    ```
    class CustomHeader: UICollectionReusableView {}

    let collectionView = UICollectionView()

    // registers the CustomCell class with a reuse identifier of "CustomHeader"
    collectionView.registerHeader(CustomHeader)
    ```
    */
    public func registerHeader<T: UICollectionReusableView>(_ type: T.Type, reuseIdentifier: String = T.className) {
        register(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
    }

    // MARK: Footers

    /**
    Registers a UICollectionReusableView for use in a UICollectionView section footer.

    - parameter type: The type of footer view to register.
    - parameter reuseIdentifier: The reuse identifier for the footer view (optional).

    By default, the class name of the footer view is used as the reuse identifier.

    Example:
    ```
    class CustomFooter: UICollectionReusableView {}

    let collectionView = UICollectionView()

    // registers the CustomFooter class with a reuse identifier of "CustomFooter"
    collectionView.registerFooter(CustomFooter)
    ```
    */
    public func registerFooter<T: UICollectionReusableView>(_ type: T.Type, reuseIdentifier: String = T.className) {
        register(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: reuseIdentifier)
    }

    /**
     Dequeues a UICollectionViewCell for use in a UICollectionView.

     - parameter type: The type of the cell.
     - parameter indexPath: The index path at which to dequeue a new cell.
     - parameter reuseIdentifier: The reuse identifier for the cell (optional).

     - returns: A force-casted UICollectionViewCell of the specified type.

     By default, the class name of the cell is used as the reuse identifier.

     Example:
     ```
     class CustomCell: UICollectionViewCell {}

     let collectionView = UICollectionView()

     // dequeues a CustomCell class
     let cell = collectionView.dequeue(CustomCell.self, forIndexPath: indexPath)
     ```
     */
    public func dequeue<T: UICollectionViewCell>(_ aClass: T.Type, forIndexPath indexPath: IndexPath) -> T! {
        return dequeueReusableCell(withReuseIdentifier: aClass.className, for: indexPath) as? T
    }

    /**
     Dequeues a UICollectionReusableView for use in a UICollectionView section header.

     - parameter type: The type of the header view.
     - parameter indexPath: The index path at which to dequeue a new header view.
     - parameter reuseIdentifier: The reuse identifier for the header view (optional).

     - returns: A force-casted UICollectionReusableView of the specified type.

     By default, the class name of the header view is used as the reuse identifier.

     Example:
     ```
     class CustomHeader: UICollectionReusableView {}

     let collectionView = UICollectionView()

     // dequeues a CustomHeader class
     let footerView = collectionView.dequeue(CustomHeader.self, forIndexPath: indexPath)
     ```
     */
    public func dequeue<T: UICollectionReusableView>(_ aClass: T.Type, type: SectionType, forIndexPath indexPath: IndexPath) -> T! {
        return dequeueReusableSupplementaryView(ofKind: type.kind, withReuseIdentifier: T.className, for: indexPath) as? T
    }

    /**
     Inserts rows into self.

     - parameter indices: The rows indices to insert into self.
     - parameter section: The section in which to insert the rows (optional, defaults to 0).
     - parameter completion: The completion handler, called after the rows have been inserted (optional).
     */
    public func insert(_ indices: [Int], section: Int = 0, completion: @escaping (Bool) -> Void = { _ in }) {
        let indexPaths = indices.map { IndexPath(row: $0, section: section) }
        performBatchUpdates({ self.insertItems(at: indexPaths) }, completion: completion)
    }

    /**
     Deletes rows from self.

     - parameter indices: The rows indices to delete from self.
     - parameter section: The section in which to delete the rows (optional, defaults to 0).
     - parameter completion: The completion handler, called after the rows have been deleted (optional).
     */
    public func delete(_ indices: [Int], section: Int = 0, completion: @escaping (Bool) -> Void = { _ in }) {
        let indexPaths = indices.map { IndexPath(row: $0, section: section) }
        performBatchUpdates({ self.deleteItems(at: indexPaths) }, completion: completion)
    }

    /**
     Reloads rows in self.

     - parameter indices: The rows indices to reload in self.
     - parameter section: The section in which to reload the rows (optional, defaults to 0).
     - parameter completion: The completion handler, called after the rows have been reloaded (optional).
     */
    public func reload(_ indices: [Int], section: Int = 0, completion: @escaping (Bool) -> Void = { _ in }) {
        let indexPaths = indices.map { IndexPath(row: $0, section: section) }
        performBatchUpdates({ self.reloadItems(at: indexPaths) }, completion: completion)
    }
    

}
