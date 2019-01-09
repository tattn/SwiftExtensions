import Foundation

public enum SafePointerConstants {
    public static var growthFactor = 2
    public static var capacityReductionOffset = 5
}

public final class SafePointer<Element>: Sequence, Collection, MutableCollection, BidirectionalCollection, RangeReplaceableCollection, RandomAccessCollection {
    var ptr: UnsafeMutablePointer<Element>
    public internal(set) var capacity: Int {
        didSet {
            ptr = realloc(UnsafeMutableRawPointer(ptr), capacity).assumingMemoryBound(to: Element.self)
        }
    }
    public internal(set) var count: Int {
        didSet {
            if count < 0 {
                fatalError("Could not remove elemnt from empty pointer")
            }
        }
    }
    public init(count: Int, capacity: Int) {
        precondition(count <= capacity)
        self.count = count
        self.capacity = capacity
        self.ptr = UnsafeMutablePointer.allocate(capacity: capacity)
    }
    public convenience init() {
        self.init(count: 0, capacity: 0)
    }
    
    func setTop(to value: Element) {
        ptr.advanced(by: count - 1).initialize(to: value)
    }
    func getTop() -> Element {
        return ptr.advanced(by: count - 1).pointee
    }
    func lowerTop(_ n: Int, _ c_incr: Int = 0) {
        count -= n
        if count + SafePointerConstants.capacityReductionOffset <= capacity {
            capacity = count + c_incr
        }
    }
    
    public func _increaseCapacity(_ newCapacity: Int) {
        self.capacity = newCapacity
    }
    public func _grow(by dsize: Int) {
        count += dsize
        if count * SafePointerConstants.growthFactor > capacity {
            let result = dsize + capacity
            _increaseCapacity(result)
        }
    }
    public func append(_ newElement: Element) {
        _grow(by: 1)
        setTop(to: newElement)
    }
    public func removeLast() -> Element {
        let current = getTop()
        lowerTop(1)
        return current
    }
    
    public subscript(stride: Int) -> Element {
        get {
            precondition(stride >= 0 && stride < count, "Index out of bounds")
            return ptr.advanced(by: stride).pointee
        }
        set {
            precondition(stride >= 0 && stride < count, "Index out of bounds")
            ptr.advanced(by: stride).initialize(to: newValue)
        }
    }
    
    deinit {
        ptr.deinitialize(count: capacity)
        ptr.deallocate()
    }
}

public extension SafePointer {
    public struct Iterator: IteratorProtocol {
        let _base: SafePointer
        var _offset, _inset: Int
        init(_base: SafePointer, _bounds: (Int, Int)) {
            precondition(_bounds.0 <= _bounds.1)
            self._base = _base
            self._offset = _bounds.0
            self._inset = _bounds.1
            self._index = _bounds.0
        }
        var _index = 0
        public mutating func next() -> Element? {
            if _index + 1 < (_base.count - _inset) {
                let temp = _index
                _index += 1
                return _base[temp]
            }
            return nil
        }
    }
    public func makeIterator() -> SafePointer<Element>.Iterator {
        return Iterator(_base: self, _bounds: (0, count))
    }
    public func makeIterator(forBounds bounds: Indices) -> SafePointer<Element>.Iterator {
        return Iterator(_base: self, _bounds: (bounds.lowerBound, bounds.upperBound))
    }
}

public extension SafePointer {
    public var startIndex: Int {
        return 0
    }
    public var endIndex: Int {
        return count
    }
    public func reserveCapacity(_ n: Int) {
        self.capacity += n
    }
    
    public func removeLast(_ n: Int) {
        lowerTop(n, 1)
    }
}
