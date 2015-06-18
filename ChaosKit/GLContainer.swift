//
//  GLContainer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

@objc
public class GLContainer: GLDisplayObject {
	
	/*
	|--------------------------------------------------------------------------
	| Stored Properties
	|--------------------------------------------------------------------------
	*/
	
	/// Caches the shapes contained in this container
	private var _shapeCache : [GLShape]?
	
	/// The children, this container contains
	public private(set) var children : [GLDisplayObject] = []
	
	/// Contains the scene to which the object belongs to
	public override var stage : GLStage? {
		didSet {
			for child in children {child.stage = stage!}
		}
	}
	
	
	/*
	|--------------------------------------------------------------------------
	| Derived Properties
	|--------------------------------------------------------------------------
	*/
	
	/// Returns all shapes within this container
	public var shapes : [GLShape] {
		get {
			_updateShapeCache()
			return _shapeCache!
		}
	}
	
	
	/*
	|--------------------------------------------------------------------------
	| Initializers
	|--------------------------------------------------------------------------
	*/
	
	/**
	Initializes the container
	*/
	public override init () {}
	
	
	/*
	|--------------------------------------------------------------------------
	| Methods
	|--------------------------------------------------------------------------
	*/
	
	
	/** 
	Adds a new child to the container 
	
	:param: child The child object to add
	*/
	public func addChild (child: GLDisplayObject) {
		if let container = child as? GLContainer {
			if container.isAncestorOf(self) {
				return println("Ancestor cannot be child of its own descendants.")
			}
		}
		
		child._parent?.removeChild(child)
		child._parent = self
		child.stage = stage
		

		
		_shapeCache = nil
		children.append(child)
	}
	
	
	/** 
	Returns the index of the child within this container, if it exists
	
	:param: child The child to get the index of
	:return: Some int value
	*/
	public func getChildIndex (child: GLDisplayObject) -> Int? {
		var index : Int = 0
		for c in children {
			if child === c {return index}
			index++
		}
		
		return nil
	}
	
	
	/**
	Removes the child from container
	
	:param: child The child object to remove
	:return: The index of the child
	*/
	public func removeChild (child: GLDisplayObject) -> Int? {
		var index : Int? = getChildIndex(child)
		if nil == index {return -1}
		
		removeChildAt(index!)
		return index!
	}
	
	
	/**
	Removes the child at given index
	
	:param: index The index of the child to remove
	:return: The display object child
	*/
	public func removeChildAt (index: Int) -> GLDisplayObject? {
		if index < 0 || index >= children.count {return nil}
		
		var child : GLDisplayObject = children[index]
		children.removeAtIndex(index)
		child._parent = nil
		
		_shapeCache = nil
		
		return child
	}
	
	
	/**
	Determines if this container is an ancestor of given display object
	*/
	public func isAncestorOf (displayObject: GLDisplayObject) -> Bool {
		var queue : Queue<GLDisplayObject> = Queue(children)
		while !queue.isEmpty {
			var obj : GLDisplayObject = queue.dequeue()!
			
			if obj === displayObject {return true}
			
			if let container = displayObject as? GLContainer {
				queue.enqueue(container.children)
			}
		}
		
		return false
	}
	
	
	/**
	Updates the shape cache
	*/
	private func _updateShapeCache () {
		if _shapeCache != nil {return}
		
		_shapeCache = []
		for child in children {
			if !child.visible {continue}
			
			if let shape = child as? GLShape {
				_shapeCache!.append(child as! GLShape)
			}
			
			if let container = child as? GLContainer {
				_shapeCache!.extend(container.shapes)
			}
		}
	}
}
