//
//  CoordinatorStack.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import Foundation

// 0: [root]
// 1: ...[child]
// 2: .......[child #1]->[child #2]
// 3: ..........................[child]

//internal class CoordinatorStack {
//
//    class Node {
//
//        private(set) var coordinator: AnyCoordinator
//        private(set) var children = [Node]()
//        weak var parent: Node?
//
//        init(coordinator: AnyCoordinator) {
//            self.coordinator = coordinator
//        }
//
//        func add(child node: Node) {
//            node.parent = self
//            self.children.append(node)
//        }
//
//    }
//
//    private(set) var root: Node
//
//    init(root: Node) {
//        self.root = root
//    }
//
//}
