//
//  GLCamera.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/** 
This class models a camera for open gl to draw a stage
*/
public final class GLCamera {
	
	/// Caches the model view matrix
	private var _transformation : mat4 = mat4.identity {
		didSet {_uniforms = nil}
	}
	
	/// Caches the uniforms
	private var _uniforms : [GLurl : GLUniform]?
	
	/// Contains the stage which the camera captures
	public var stage : GLStage?
	
	/// Contains the projection matrix of the camera
	public var projection : GLCameraProjection {
		didSet {_uniforms = nil}
	}
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the x position
	public var x : GLfloat {
		get {return _transformation[0, 3]}
		set {_transformation.translateX(-newValue)}
	}
	
	/// Provides the x position
	public var y : GLfloat {
		get {return _transformation[1, 3]}
		set {_transformation.translateY(-newValue)}
	}
	
	/// Provides the x position
	public var z : GLfloat {
		get {return _transformation[2, 3]}
		set {_transformation.translateZ(-newValue)}
	}
	
	/// Provides the position of the object as vector
	public var position : vec3 {
		get {return -vec3(_transformation[col: 3])}
		set {_transformation.translate(-newValue)}
	}
	
	/// Provides the x position
	public var rx : GLfloat {
		get {
			let r32 = _transformation[2,1]
			let r33 = _transformation[2,2]
			return atan2(r32, r33)
		}
		set {_transformation.rotateX(rad: -newValue)}
	}
	
	/// Provides the x position
	public var ry : GLfloat {
		get {
			let r31 = _transformation[2,0]
			let r32 = _transformation[2,1]
			let r33 = _transformation[2,2]
			return atan2(-r31, sqrt(pow(r32, 2.0) + pow(r33, 2.0)))
		}
		set {_transformation.rotateY(rad: -newValue)}
	}
	
	/// Provides the x position
	public var rz : GLfloat {
		get {
			let r11 = _transformation[0,0]
			let r21 = _transformation[1,0]
			return atan2(r21, r11)
		}
		set {_transformation.rotateZ(rad: -newValue)}
	}
	
	/// Provides the rotation around the x, y and z axis
	public var rotation : vec3 {
		get {return vec3(-rx, -ry, -rz)}
	}
	
	
	/// Provides the uniforms
	public var uniforms : [GLurl : GLUniform] {
		get {
			if _uniforms == nil {
				_uniforms = [
					GLurl(.Camera, .Transformation) : GLUniformMatrix4fv(_transformation),
					GLurl(.Camera, .Projection) : GLUniformMatrix4fv(projection.matrix),
					GLurl(.Camera, .Position) : GLUniform3f(position.x, position.y, position.z)
				]
			}
			
			return _uniforms!
		}
	}
	
	
	/**
	Initializes the camera with a given projection
	
	:param: projection
	*/
	public init (projection: GLCameraProjection) {
		self.projection = projection
	}
	
	
	/**
	Initializes the camera with a orthographic projection
	*/
	public convenience init () {
		self.init(projection: GLOrthographicProjection(GLViewVolume()))
	}
	
	
	public func resetTransformation () {
		_transformation = mat4.identity
	}
	
	
	/**
	Rotates the camera to a given position
	
	:param: position
	*/
	public func lookAt (position: vec3) {
		
	}
}