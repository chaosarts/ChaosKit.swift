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
	
	/// Caches the shapes contained in this container
	private var _shapeCache : [GLShape]?
	
	/// Contains the scene to which the object belongs to
	public override var stage : GLStage? {
		didSet {
			for child in _children {
				child.stage = stage
			}
		}
	}
	
	/// The children, this container contains
	public var children : [GLDisplayObject] {
		get {return _children}
	}
	
	
	public var shapes : [GLShape] {
		get {
			if _shapeCache == nil {updateShapeCache()}
			return _shapeCache!
		}
	}
	
	
	/**
	Initializes the container
	*/
	public override init () {}
	
	
	/** 
	Adds a new child to the container 
	*/
	public func addChild (child: GLDisplayObject) {
		if isAncestor(child) {return println("Ancestor cannot be child of its own descendants.")}
		
		child.parent = self
		if stage != nil {child.stage = stage}
		
		_shapeCache = nil
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
		
		_shapeCache = nil
		
		return child
	}
	
	
	private func updateShapeCache () {
		_shapeCache = []
		for child in _children {
			if let shape = child as? GLShape {
				_shapeCache!.append(shape)
			}
			
			if let container = child as? GLContainer {
				_shapeCache!.extend(container.shapes)
			}
		}
	}
	
	
	public func isAncestor (displayObject: GLDisplayObject) -> Bool {
		var queue : CCQueue<GLDisplayObject> = CCQueue<GLDisplayObject>(children)
		while !queue.empty {
			var child : GLDisplayObject = queue.dequeue()!
			if let container = child as? GLContainer {
				if container ===  displayObject {return true}
				queue.enqueue(container.children)
			}
			
			if child === displayObject {return true}
		}
		return false
	}
}
