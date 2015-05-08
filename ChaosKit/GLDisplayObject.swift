//
//  GLDisplayObject.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

internal class GLDisplayObjectManager {
	
	private static var instance : GLDisplayObjectManager?
	
	class func getInstance () -> GLDisplayObjectManager {
		if instance == nil {
			instance = GLDisplayObjectManager()
		}
		
		return instance!
	}
	
	private var _id : DisplayObjectID
	
	private init () {
		_id = 0
	}
	
	
	func generateId () -> UInt32 {
		return _id++
	}
}

/**
Base class for displayable objects. Does not implement the GLDisplayable
protocol, since it is 'abstract' and therefore it is unknown what to do in 
display method.
*/
public class GLDisplayObject : NSObject, Equatable {
	
	/// Provides the id of the display object
	internal var _id : DisplayObjectID
	
	/// Caches the transformation matrix
	private var _cache : mat4?
	
	
	/// Provides the position of the object as vector
	public var position : vec3 = vec3() {
		didSet {_cache = nil}
	}
	
	/// Provides the rotation around the x, y and z axis
	public var rotation : vec3 = vec3 () {
		didSet {_cache = nil}
	}
	
	/// Provides the scale in x, y and z direction
	public var scale : vec3 = vec3 (1, 1, 1) {
		didSet {_cache = nil}
	}
	
	/// Contains the shear in x, y and z direction
	public var shear : vec3 = vec3 (0, 0, 0) {
		didSet {_cache = nil}
	}
	
	/// Provides the x position
	public var x : GLfloat {
		get {return position.x}
		set {position.x = newValue}
	}
	
	/// Provides the y position
	public var y : GLfloat {
		get {return position.y}
		set {position.y = newValue}
	}
	
	/// Provides the z position
	public var z : GLfloat {
		get {return position.z}
		set {position.z = newValue}
	}
	
	/// Indicates if the displayable is visible or not
	public var visible : Bool = true
	
	/// Contains the parent element
	public var parent : GLContainer?

	/// Contains the scene to which the object belongs to
	public var stage : GLStage?
	
	/// Provides the model view matrix of the object
	public var modelViewMatrix : mat4 {
		get {
			if _cache == nil {
				_cache = mat4.makeRotationX(deg: rotation.x)
				_cache!.rotateY(deg: rotation.y)
				_cache!.rotateZ(deg: rotation.z)
				_cache!.translate(position)
			}
			
			return _cache!
		}
	}
	
	/// Contains the model view matrix
	public var normalViewMatrix : mat4 {
		get {
			return modelViewMatrix
		}
	}
	
	/// Initializes the object
	internal override init () {
		_id = GLDisplayObjectManager.getInstance().generateId()
	}
	
	/// Resets all transformations
	public func resetTransformation () {
		_cache = nil
		rotation = vec3()
		position = vec3()
	}
}


public func ==(l: GLDisplayObject, r: GLDisplayObject) -> Bool {
	return l === r
}
