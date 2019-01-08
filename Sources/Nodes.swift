public final class Node<T> {
  public var value: T
  public internal(set) weak var parent: Node<T>?
  public internal(set) var children: [Node<T>]
  
  public init(storing value: T) {
    self.value = value
    self.children = []
  }
  public func addChild(_ child: Node<T>) {
    child._configure(with: self)
  }
  public func _configure(with parent: Node<T>?) {
    self.parent = parent
    parent?.children.append(self)
  }
}

public extension Node {
  public var depth: Int {
    if let parent = parent {
      return parent.depth + 1
    } else {
      return 1
    }
  }
}

public extension Node where Element: Equatable {
  public func search(for value: T) -> Node<T>? {
    if self.value == value { return self }
    for child in children {
      if let node = child.search(for: value) {
        return node
      }
    }
    return nil
  }
}

public typealias BinaryTree<T: Equatable> = Node<T>
