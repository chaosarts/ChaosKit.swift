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
	
	/// Caches the shapes contained in this container
	private var _lightCache : [GLLight]?
	
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
	
	
	public var lights : [GLLight] {
		get {
			if _lightCache == nil {updateLightCache()}
			return _lightCache!
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
		child.parent = self
		if stage != nil {child.stage = stage}
		
		_shapeCache = nil
		_lightCache = nil
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
		_lightCache = nil
		
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
	
	
	private func updateLightCache () {
		_lightCache = []
		for child in _children {
			if let light = child as? GLLight {
				_lightCache!.append(light)
			}
			
			if let container = child as? GLContainer {
				_lightCache!.extend(container.lights)
			}
		}
	}
}
