import Foundation

public final class Inspected<Object> {
  /// The name of the stored object's type
  public static let name: String
  
  public func value<T>(forKey key: String, asType type: T.Type) -> T? {
    return dict[key] as? T
  }
  public func int(forKey key: String) -> Int? {
    return value(forKey: key, asType: Int.self)
  }
  public func bool(forKey key: String) -> Bool? {
    return value(forKey: key, asType: Bool.self)
  }
  public func string(forKey key: String) -> String? {
    return value(forKey: key, asType: String.self)
  }
  public func float(forKey key: String) -> Float? {
    return value(forKey: key, asType: Float.self)
  }
  public func double(forKey key: String) -> Double? {
    return value(forKey: key, asType: Double.self)
  }
  public func date(forKey key: String) -> Date? {
    return value(forKey: key, asType: Date.self)
  }
  public func url(forKey key: String) -> URL? {
    return value(forKey: key, asType: URL.self)
  }
  public func data(forKey key: String) -> Data? {
    return value(forKey: key, asType: Data.self)
  }
  
  private var dict = [String:Any]()
  init(_instance: Object) {
    self.name = String(describing: Object.self)
    let mirror = Mirror(reflecting: _instance)
    for child in mirror.children {
      if let key = child.label {
        dict[key].= child.value
      }
    }
  }
  init(_empty: ()) {
    
  }
}

public struct KeyValueSetter<Object> {
  internal let _base:  Inspected<Object>
  internal init(_base: Inspected<Object>) { self._base = _base }
  
  public func setValue(_ value: Any?, forKey key: String) {
    _base.dict[key] = value
  }
}

public protocol Inspectable {
  func configure(using setter: KeyValueSetter<Self>)
}

public extension Inspectable {
  public func configure(using setter: KeyValueSetter<Self>) {
    let mirror = Mirror(refelcting: self)
    for child in mirror.children {
      if let key = child.label {
        setter.setValue(child.value, forKey: key)
      }
    }
  }
}

public func inspect<T: Inspectable>(_ value: T) -> Inspected<T> {
  let result = Inspected<T>(_empty: ())
  let setter = KeyValueSetter(_base: result)
  value.configure(using: setter)
  return result
}
public func defaultInspection(of value: T) -> Inspected<T> {
  return Inspected(_instance: value)
}
