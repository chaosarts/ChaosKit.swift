//
//  GLDisplayObjectBase.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

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
	private var _modelViewMatrix : mat4?
	
	/// Provides the parent container
	internal var _parent : GLContainer?
	
	/// Returns the id of the object
	public var id : Identifier = ""
	
	/// Provides the anchor to rotate around
	public var anchor : vec3 = vec3()
	
	/// Provides the position of the object as vector
	public var position : vec3 = vec3() {
		didSet {_modelViewMatrix = nil}
	}
	
	/// Provides the rotation around the x, y and z axis
	public var rotation : vec3 = vec3 () {
		didSet {_modelViewMatrix = nil}
	}
	
	/// Provides the scale in x, y and z direction
	public var scaling : vec3 = vec3 (1, 1, 1) {
		didSet {_modelViewMatrix = nil}
	}
	
	/// Contains the shear in x, y and z direction
	public var shearing : vec3 = vec3 (0, 0, 0) {
		didSet {_modelViewMatrix = nil}
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
			if _modelViewMatrix == nil {
				_modelViewMatrix = mat4.makeRotationX(deg: rotation.x)
				_modelViewMatrix!.rotateY(deg: rotation.y)
				_modelViewMatrix!.rotateZ(deg: rotation.z)
				_modelViewMatrix!.translate(position)
			}
			
			if nil == parent {return _modelViewMatrix!}
			return parent!.modelViewMatrix * _modelViewMatrix!
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
		_modelViewMatrix = nil
		rotation = vec3()
		position = vec3()
		shearing = vec3()
		scaling = vec3()
	}
}
