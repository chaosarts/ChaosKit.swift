//
//  GLContainer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class GLContainer: GLDisplayObject {
	
	/// The children, this container contains
	private var _children : [GLDisplayObject] = []
	
	/// The children, this container contains
	public var children : [GLDisplayObject] {
		get {return _children}
	}
	
	
	/**
	Initializes the container
	*/
	public override init () {}
	
	/**
	Displays the object
 	*/
	public override func display () {
		for child in _children {
			child.display()
		}
	}
	
	
	/** 
	Adds a new child to the container 
	*/
	public func addChild (child: GLDisplayObject) {
		_children.append(child)
	}
	
	
	public func removeChild (child: GLDisplayObject) -> Int {
		var index : Int? = find(_children, child)
		if nil == index {return -1}
		removeChildAt(index!)
		return index!
	}
	
	
	public func removeChildAt (index: Int) -> GLDisplayObject? {
		if index < 0 || index >= _children.count {return nil}
		var child : GLDisplayObject = _children[index]
		_children.removeAtIndex(index)
		child.parent = nil
		return child
	}
}
