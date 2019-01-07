//: Playground - noun: a place where people can play

import CoreGraphics

public protocol CoordType {
    associatedtype Scalar: FloatingPoint
    var x: Scalar { get }
    var y: Scalar { get }
}

public protocol CoordInitType: CoordType {
    init(x: Scalar, y: Scalar)
    static var zero: Self { get }
}

public extension CoordInitType {
    public static var zero: Self { return  Self(x: 0, y: 0) }
}

public protocol SizeType {
    associatedtype Scalar: FloatingPoint
    var width: Scalar { get }
    var height: Scalar { get }
}

public protocol RectType: SizeType {
    associatedtype Point: CoordInitType where Point.Scalar == Scalar
    var origin: Point { get }
    var center: Point { get }
}

public extension RectType {
    public var center: Point {
        return Point(x: origin.x + width / 2, y: origin.y + height / 2)
    }
}

public enum CoordSystem: Int {
    case originTopLeft
    case originCenter
}

public protocol CoordConvertible {
    associatedtype Point: CoordInitType
    static var coordinateSystem: CoordSystem { get }
}

public extension CoordConvertible {
    public static func _convert(
        _ point: Point,
        to other: CoordSystem,
        bounds: (width: Point.Scalar, height: Point.Scalar)
        ) -> Point {
        switch coordinateSystem {
        case .originTopLeft:
            switch other {
            case .originTopLeft:
                return point
            case .originCenter:
                return Point(x: point.x + bounds.width / 2, y: point.y + bounds.height / 2)
            }
        case .originCenter:
            switch other {
            case .originTopLeft:
                return Point(x: point.x - bounds.width / 2, y: point.y - bounds.height / 2)
            case .originCenter:
                return point
            }
        }
    }
    public static func convert<Size: SizeType>(
        _ point: Point,
        to other: CoordSystem,
        bounds: Size
        ) -> Point where Size.Scalar == Point.Scalar {
        return _convert(point, to: other, bounds: (bounds.width, bounds.height))
    }
}

public extension CoordConvertible where Self: SizeType, Self.Scalar == Point.Scalar {
    public func convert(
        _ point: Point,
        to other: CoordSystem
        ) -> Point {
        return Self._convert(point, to: other, bounds: (width, height))
    }
}

extension CGPoint: CoordInitType {}
extension CGSize: SizeType {}
extension CGRect: RectType {}

#if !os(macOS)
import UIKit
extension UIView: CoordConvertible, SizeType {
    public var width: CGFloat { return bounds.width }
    public var height: CGFloat { return bounds.height }
    
    public typealias Point = CGPoint
    public static let coordinateSystem: CoordSystem = .originTopLeft
}

public extension UIView {
    public func convertToCenter(_ point: CGPoint) -> CGPoint {
        return convert(point, to: .originCenter)
    }
}
#endif

