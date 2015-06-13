//
//  GLDisplayObjectBase.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

//public protocol GLDisplayObject {
//	
//	/// Provides the display object id
//	var id : GLDisplayObjectId {get set}
//	
//	/// Provides the anchor to rotate around
//	var anchor : vec3 {get set}
//	
//	/// Provides the position of the object as vector
//	var position : vec3 {get set}
//	
//	/// Provides the rotation around the x, y and z axis
//	var rotation : vec3 {get set}
//	
//	/// Provides the scale in x, y and z direction
//	var scaling : vec3 {get set}
//	
//	/// Provides the shearing in x, y and z direction
//	var shearing : vec3 {get set}
//	
//	/// Provides the x position
//	var x : GLfloat {get set}
//	
//	/// Provides the y position
//	var y : GLfloat {get set}
//	
//	/// Provides the z position
//	var z : GLfloat {get set}
//	
//	/// Indicates if the displayable is visible or not
//	var visible : Bool {get set}
//	
//	/// Contains the parent element
//	var parent : GLContainer? {get}
//	
//	/// Contains the scene to which the object belongs to
//	var stage : GLStage? {get set}
//	
//	/// Provides the model view matrix of the object
//	var modelViewMatrix : mat4 {get}
//	
//	/// Contains the model view matrix for normals
//	var normalViewMatrix : mat4 {get}
//}

/**
Base class for displayable objects. Does not implement the GLDisplayable
protocol, since it is 'abstract' and therefore it is unknown what to do in 
display method.
*/
@objc
public class GLDisplayObject : Identifiable {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Caches the transformation matrix
	private var _cache : mat4?
	
	internal var _parent : GLContainer?
	
	/// Returns the id of the object
	public var id : Identifier = ""
	
	/// Provides the anchor to rotate around
	public var anchor : vec3 = vec3()
	
	/// Provides the position of the object as vector
	public var position : vec3 = vec3() {
		didSet {_cache = nil}
	}
	
	/// Provides the rotation around the x, y and z axis
	public var rotation : vec3 = vec3 () {
		didSet {_cache = nil}
	}
	
	/// Provides the scale in x, y and z direction
	public var scaling : vec3 = vec3 (1, 1, 1) {
		didSet {_cache = nil}
	}
	
	/// Contains the shear in x, y and z direction
	public var shearing : vec3 = vec3 (0, 0, 0) {
		didSet {_cache = nil}
	}
	
	/// Contains the scene to which the object belongs to
	public var stage : GLStage?
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
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
	public var parent : GLContainer? {
		get {return _parent}
	}
	
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
	
	
	/*
	|--------------------------------------------------------------------------
	| Initializers
	|--------------------------------------------------------------------------
	*/
	
	/// Initializes the object
	internal init () {}
	
	
	/*
	|--------------------------------------------------------------------------
	| Methods
	|--------------------------------------------------------------------------
	*/
	
	/// Resets all transformations
	public func resetTransformation () {
		_cache = nil
		rotation = vec3()
		position = vec3()
		shearing = vec3()
		scaling = vec3()
	}
}
