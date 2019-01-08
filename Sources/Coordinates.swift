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

/*
 A type that can be used for converting points into different coordinate systems.
 
 Use like this:
 
 
 var view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
 view.convertToCenter(CGPoint(x: 0, y: 0)) == CGPoint(x: 50, y: 50) // true
 
 You can also define custom overloads using the `CoordConvertible` protocol. This is how MyStruct is defined:
 
 
 struct MyStruct: CoordConvertible {
 typealias Point = MyPoint
 static let coordinateSystem: CoordSystem == .originCenter
 }
 
 
 For free you get the static method `convert(_:to:bounds:)`, and if you also conform to `SizeType` you one extra instance method.
 
 // The free static method
 MyStruct.convert(myPoint, to: .originTopLeft, bounds: someBounds)
 
 // SizeType
 extension MyStruct: SizeType {
 var width = ...
 var height = ...
 }
 
 myStruct.convert(myPoint, to: .originTopLeft)
 
 All of the standard CoreGraphics types conform to the protocols, so for example `CGRect` is a `RectType` and UIViews conform to `CoordConvertible` and `SizeType`.
 */
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

#if os(macOS)
import AppKit
extension NSView: CoordConvertible, SizeType {
    public var width: CGFloat { return bounds.width }
    public var height: CGFloat { return bounds.height }
    
    public typealias Point = CGPoint
    public static let coordinateSystem: CoordSystem = .originTopLeft
}

public extension NSView {
    public func convertToCenter(_ point: CGPoint) -> CGPoint {
        return convert(point, to: .originCenter)
    }
}
#else
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

