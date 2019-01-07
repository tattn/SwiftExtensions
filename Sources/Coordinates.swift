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
    public static func convert<Size: SizeType>(
        _ point: Point,
        to other: CoordSystem,
        bounds: Size
        ) -> Point where Size.Scalar == Point.Scalar {
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
        return UIView.convert(point, to: .originCenter, bounds: bounds)
    }
}
#endif

