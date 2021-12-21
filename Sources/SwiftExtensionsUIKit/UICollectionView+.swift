//
//  UICollectionView+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171213.
//  Copyright © 2017 tattn. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import UIKit

public extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func register(cellTypes: [UICollectionViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func register(reusableViewType: UICollectionReusableView.Type,
                         ofKind kind: String = UICollectionView.elementKindSectionHeader,
                         bundle: Bundle? = nil) {
        let className = reusableViewType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    func register(reusableViewTypes: [UICollectionReusableView.Type],
                         ofKind kind: String = UICollectionView.elementKindSectionHeader,
                         bundle: Bundle? = nil) {
        reusableViewTypes.forEach { register(reusableViewType: $0, ofKind: kind, bundle: bundle) }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                             for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }

    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                                 for indexPath: IndexPath,
                                                                 ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as! T
    }
}
#endif // canImport(UIKit)
