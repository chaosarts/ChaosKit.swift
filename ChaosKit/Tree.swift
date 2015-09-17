//
//  Tree.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol TreeTraverseStrategy {}


public final class TreeNode<T> : Hierarchy, Valuable {
	
	public typealias Element = T
	
	typealias Type = TreeNode<Element>
	
	public var value : Element
	
	public private(set) var parent : Type?
	
	public var children : [Type] = []
	
	public init (_ value: Element) {
		self.value = value
	}
}


public class Tree<T> {
	
	typealias Element = T
	
	typealias Node = TreeNode<T>
	
	public var root : Node
	
	public init (root: Node) {
		self.root = root
	}
}