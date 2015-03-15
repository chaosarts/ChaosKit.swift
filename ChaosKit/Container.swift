//
//  Container.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class Container: DisplayObject {
	
	/// The children, this container contains
	private var _children : [DisplayObject] = []
	
	/// The children, this container contains
	public var children : [DisplayObject] {
		get {return _children}
	}
	
	
	/**
	Initializes the container
	*/
	public override init () {}
	
	
	/** 
	Adds a new child to the container 
	*/
	public func addChild (child: DisplayObject) {
		_children.append(child)
	}
	
	
	public func removeChild (child: DisplayObject) -> Int {
		var index : Int? = find(_children, child)
		if nil == index {return -1}
		removeChildAt(index!)
		return index!
	}
	
	
	public func removeChildAt (index: Int) -> DisplayObject? {
		if index < 0 || index >= _children.count {return nil}
		var child : DisplayObject = _children[index]
		_children.removeAtIndex(index)
		return child
	}
}
