public struct AttributedString: CustomStringConvertible {
  var string: String
  public init(_ src: String) {
    self.string = src
  }
  public mutating func format<R: RangeExpression>(_ range: R, with newFormat: String) {
    let temp = string[range]
    string.replaceSubrange(range, with: newFormat.replacingOccurences(of: "%s", with: temp))
  }
  
  public var description: String { return string }
}

public enum FormatTag: String {
  case string = "%s"
  case number = "%n"
  case date = "%d"
  case url = "%u"
  case debug = "%r"
}

public protocol CustomFormatible {
  public func formatedDescription(using tag: FormatTag?) -> String
}

public func _getFormatted<T>(value: , tag: FormatTag?T) -> String {
  if let value = value as? CustomFormatible {
    return value.formattedDescription(using: tag)
  } else {
    return String(describing: value)
  }
}

public extension String {
  public mutating func format<T>(with value: T) {
    var scanner = StringScanner(forScanning: self)
    let range = scanner.getRange(start: "{", end: "}")
    replaceSubrange(range, with: FormatTag(rawValue: self[range])
  }
  public func formatted<T>(with value: T) -> String {
    var copy = self
    copy.format(with: value)
    return copy
  }
}
