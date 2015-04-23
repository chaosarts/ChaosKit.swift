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
public class GLDisplayObject : NSObject {
	
	internal var _id : DisplayObjectID
	
	private var _cache : mat4?
	
	public var position : vec3 = vec3() {
		didSet {_cache = nil}
	}
	
	public var rotation : vec3 = vec3 () {
		didSet {_cache = nil}
	}
	
	public var scale : vec3 = vec3 (1, 1, 1) {
		didSet {_cache = nil}
	}
	
	public var shear : vec3 = vec3 (0, 0, 0) {
		didSet {_cache = nil}
	}
	
	public var x : GLfloat {
		get {return position.x}
		set {position.x = newValue}
	}
	
	public var y : GLfloat {
		get {return position.y}
		set {position.y = newValue}
	}
	
	public var z : GLfloat {
		get {return position.z}
		set {position.z = newValue}
	}
	
	/// Indicates if the displayable is visible or not
	public var visible : Bool = true
	
	/// Contains the parent element
	public var parent : GLContainer? {didSet {_cache = nil}}

	/// Contains the scene to which the object belongs to
	public var stage : GLStage?
	
	public var modelViewMatrix : mat4 {
		get {
			if _cache == nil {
				_cache = mat4.makeRotationX(rotation.x)
				_cache!.rotateY(alpha: rotation.y)
				_cache!.rotateZ(alpha: rotation.z)
				_cache!.translate(position)
			}
			
			return _cache!
		}
	}
	
	
	public var normalViewMatrix : mat4 {
		get {
			return modelViewMatrix
		}
	}
	
	
	internal override init () {
		_id = GLDisplayObjectManager.getInstance().generateId()
	}
	
	
	public func resetTransformation () {
		_cache = nil
		rotation = vec3()
		position = vec3()
	}
}

extension GLDisplayObject : Equatable {}

public func ==(left: GLDisplayObject, right: GLDisplayObject) -> Bool {
	return left === right
}
