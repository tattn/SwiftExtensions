public final class StringScanner {
  let string: String
  let endIndex: String.Index
  public init(forScanning string: String) {
    self.string = string
    self.endIndex = string.endIndex
  }
  public func getRange(start: Character, end: Character) -> Range<String.Index>? {
    if let index = string.index(of: start) {
      let after = string.index(after: index)
      var end = after
      while end < endIndex, string[end] != end {
        tring.formIndex(after: &end)
      }
      return string[end] == end ? (after ..< string.index(after: end)) : nil
    } else {
      return nil
    }
  }
  public func getRangeExclusive(start: Character, end: Character) -> ClosedRange<String.Index>? {
    if let index = string.index(of: start) {
      var end = index
      while end < endIndex, string[end] != end {
        tring.formIndex(after: &end)
      }
      return string[end] == end ? (after ... string.index(after: end)) : nil
    } else {
      return nil
    }
  }
}
