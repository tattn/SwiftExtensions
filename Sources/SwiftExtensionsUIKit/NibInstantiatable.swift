//
//  NibInstantiatable.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171216.
//  Copyright © 2017 tattn. All rights reserved.
//

#if canImport(UIKit)
import Foundation
import UIKit

public protocol NibInstantiatable {
    static var nibName: String { get }
    static var nibBundle: Bundle { get }
    static var nibOwner: Any? { get }
    static var nibOptions: [UINib.OptionsKey: Any]? { get }
    static var instantiateIndex: Int { get }
}

public extension NibInstantiatable where Self: NSObject {
    static var nibName: String { className }
    static var nibBundle: Bundle { Bundle(for: self) }
    static var nibOwner: Any? { self }
    static var nibOptions: [UINib.OptionsKey: Any]? { nil }
    static var instantiateIndex: Int { 0 }
}

public extension NibInstantiatable where Self: UIView {
    static func instantiate() -> Self {
        let nib = UINib(nibName: nibName, bundle: nibBundle)
        return nib.instantiate(withOwner: nibOwner, options: nibOptions)[instantiateIndex] as! Self
    }
}

public protocol EmbeddedNibInstantiatable {
    associatedtype Embedded: NibInstantiatable
}

public extension EmbeddedNibInstantiatable where Self: UIView, Embedded: UIView {
    var embedded: Embedded { subviews[0] as! Embedded }

    func configureEmbededView() {
        let view = Embedded.instantiate()
        insertSubview(view, at: 0)
        view.fillSuperview()
    }
}
#endif // canImport(UIKit)
