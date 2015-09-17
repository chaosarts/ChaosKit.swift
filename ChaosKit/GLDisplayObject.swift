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

public class GLDisplayObject : Identifiable {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Caches the uniforms for the draw call
	internal var _uniforms : [GLurl : GLUniform]?
	
	/// Caches the transformation matrix
	private var _transformation : mat4 = mat4.identity {didSet {_uniforms = nil}}
	
	/// Provides the parent container
	internal var _parent : GLContainer?
	
	/// Returns the id of the object
	public var id : Identifier = ""
	
	/// Provides the anchor to rotate around
	public var anchor : vec3 = vec3()
	
	/// Indicates if the displayable is visible or not
	public var visible : Bool = true
	
	/// Contains the scene to which the object belongs to
	public var stage : GLStage?
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the x position
	public var x : GLfloat {
		get {return _transformation[0, 3]}
		set {_transformation.translateX(newValue)}
	}
	
	/// Provides the x position
	public var y : GLfloat {
		get {return _transformation[1, 3]}
		set {_transformation.translateY(newValue)}
	}
	
	/// Provides the x position
	public var z : GLfloat {
		get {return _transformation[2, 3]}
		set {_transformation.translateZ(newValue)}
	}
	
	/// Provides the x position
	public var rx : GLfloat {
		get {
			let r32 = _transformation[2,1]
			let r33 = _transformation[2,2]
			return atan2(r32, r33)
		}
		set {_transformation.rotateX(rad: newValue)}
	}
	
	/// Provides the x position
	public var ry : GLfloat {
		get {
			let r31 = _transformation[2,0]
			let r32 = _transformation[2,1]
			let r33 = _transformation[2,2]
			return atan2(-r31, sqrt(pow(r32, 2.0) + pow(r33, 2.0)))
		}
		set {_transformation.rotateY(rad: newValue)}
	}
	
	/// Provides the x position
	public var rz : GLfloat {
		get {
			let r11 = _transformation[0,0]
			let r21 = _transformation[1,0]
			return atan2(r21, r11)
		}
		set {_transformation.rotateZ(rad: newValue)}
	}
	
	/// Provides the position of the object as vector
	public var position : vec3 {
		get {return vec3(_transformation[col: 3])}
		set {_transformation.translate(newValue)}
	}
	
	/// Provides the rotation around the x, y and z axis
	public var rotation : vec3 {
		get {return vec3(rx, ry, rz)}
	}
	
	/// Contains the parent element
	public var parent : GLContainer? {
		get {return _parent}
	}
	
	/// Provides the transformation of the object
	public var transformation : mat4 {
		get {
			var transformation : mat4 = _transformation
			if nil != _parent {transformation = _parent!.transformation * _transformation}
			return transformation
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
		_transformation = mat4.identity
	}
}
