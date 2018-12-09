//
//  UICollectionViewTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 20171213.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions
import UIKit

final class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
}

final class CollectionViewHeaderView: UICollectionReusableView {
    @IBOutlet weak var label: UILabel!
}

class UICollectionViewTests: XCTestCase {
    
    func testRegisterAndDequeueReusableCell() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self // must need a datasource
        collectionView.register(cellTypes: [CollectionViewCell.self], bundle: Bundle(for: UICollectionViewTests.self))

        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.dequeueReusableCell(with: CollectionViewCell.self, for: indexPath)
        XCTAssertNotNil(cell.label)
        collectionView.dataSource = nil
    }

    func testRegisterAndDequeueReusableView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self // must need a datasource
        collectionView.register(cellTypes: [CollectionViewCell.self], bundle: Bundle(for: UICollectionViewTests.self))
        collectionView.register(reusableViewTypes: [CollectionViewHeaderView.self],
                                ofKind: UICollectionView.elementKindSectionHeader,
                                bundle: Bundle(for: UICollectionViewTests.self))

        let indexPath = IndexPath(item: 0, section: 0)
        _ = collectionView.dequeueReusableCell(with: CollectionViewCell.self, for: indexPath) // must call before dequeueReusableView
        let view = collectionView.dequeueReusableView(with: CollectionViewHeaderView.self,
                                                      for: indexPath,
                                                      ofKind: UICollectionView.elementKindSectionHeader)
        XCTAssertNotNil(view.label)
        collectionView.dataSource = nil
    }
}

extension UICollectionViewTests: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return .init()
    }
}
