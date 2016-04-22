//
//  main.swift
//  BinarySearchTree
//
//  Created by Gregory Stula on 4/22/16.
//  Copyright © 2016 Gregory Stula. All rights reserved.
//

import Foundation

extension SequenceType {
    func all (predicate: Generator.Element -> Bool) -> Bool {
        for x in self where !predicate (x) {
            return false
        }
        return true
    }
}


indirect enum BSTree<Element:Comparable> {
    case Leaf // aka Empty node
    case Node(BSTree<Element>, Element, BSTree<Element>)

    init() {
        self = .Leaf
    }
    
    init(_ value: Element) {
        self = .Node(.Leaf, value, .Leaf)
    }

    var count: Int {
        switch self {
        case .Leaf:
            return 0
        case let .Node(left, _, right):
            return 1 + left.count + right.count
        }
    }
    
    var elements: [Element] {
        switch self {
        case .Leaf:
            return []
        case let .Node (left, x, right):
            return left.elements + [x] + right.elements
        }
    }
    
    var isEmpty: Bool {
        if case .Leaf = self {
            return true
        } else {
            return false
        }
    }
    
    var isBSTree: Bool {
        switch self {
        case .Leaf:
            return true
        case let .Node (left, x, right):
            return left.elements.all { y in y < x }
                && right.elements.all { y in y > x }
                && left.isBSTree
                && right.isBSTree
        }
    }
    
    func contains (x: Element) -> Bool {
        switch self {
        case .Leaf:
            return false
        case let .Node (_, y, _ ) where x == y:
            return true
        case let .Node (left, y , _ ) where x < y :
            return left.contains (x)
        case let .Node (_, y, right) where x > y:
            return right.contains (x)
        default:
            fatalError("The impossible occurred")
        }
    }
    
    mutating func insert (x: Element) {
        switch self {
        case .Leaf:
            self = BSTree (x)
        case .Node(var left, let y, var right):
            if x < y { left.insert (x) }
            if x > y { right.insert (x) }
            self = .Node(left, y, right)
        }
    }
}