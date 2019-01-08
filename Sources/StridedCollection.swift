public struct StridedCollection<Element: Strideable>: Sequence {
    public typealias _Base = StrideTo<Element>
    public typealias Iterator = _Base.Iterator
    var _start, _end: Element
    var _stride: Element.Stride
    public func makeIterator() -> Iterator {
        return stride(from: _start, to: _end, by: _stride).makeIterator()
    }
    
    internal init(_start: Element, _end: Element, _stride: Element.Stride) {
        self._start = _start
        self._end = _end
        self._stride = _stride
    }
}

extension StridedCollection: Collection where Element: Comparable {
    public var startIndex: Element {
        return _start
    }
    public var endIndex: Element {
        return _end
    }
    public func index(after i: Element) -> Element {
        return i.advanced(by: _stride)
    }
    public subscript(position: Element) -> Element {
        precondition(position >= _start && position < _end)
        return position
    }
}

public extension Range where Bound: Strideable {
    public func strided(by stride: Bound.Stride) -> StridedCollection<Bound> {
        return StridedCollection(_start: lowerBound, _end: upperBound, _stride: stride)
    }
}

public extension ClosedRange where Bound: Strideable {
    public func strided(by stride: Bound.Stride) -> StridedCollection<Bound> {
        return StridedCollection(_start: lowerBound, _end: upperBound.advanced(by: stride), _stride: stride)
    }
}
