//
//  NibInstantiatable.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171216.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

public protocol NibInstantiatable {
    static var nibName: String { get }
    static var nibBundle: Bundle { get }
    static var nibOwner: Any? { get }
    static var nibOptions: [AnyHashable: Any]? { get }
    static var instantiateIndex: Int { get }
}

extension NibInstantiatable where Self: NSObjectProtocol {
    public static var nibName: String { return className }
    public static var nibBundle: Bundle { return Bundle(for: self) }
    public static var nibOwner: Any? { return self }
    public static var nibOptions: [AnyHashable: Any]? { return nil }
    public static var instantiateIndex: Int { return 0 }
}

extension NibInstantiatable where Self: UIView {
    public static func instantiate() -> Self {
        let nib = UINib(nibName: nibName, bundle: nibBundle)
        return nib.instantiate(withOwner: nibOwner, options: nibOptions)[instantiateIndex] as! Self
    }
}

public protocol EmbeddedNibInstantiatable {
    associatedtype Embedded: NibInstantiatable
}

extension EmbeddedNibInstantiatable where Self: UIView, Embedded: UIView {
    public var embedded: Embedded { return subviews[0] as! Embedded }

    public func configureEmbededView() {
        let view = Embedded.instantiate()
        insertSubview(view, at: 0)
        view.fillSuperview()
    }
}
