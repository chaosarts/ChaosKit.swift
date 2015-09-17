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
	
	/// Caches the uniforms
	private var _uniforms : [GLurl : GLUniform]?
	
	/// Caches the transformation matrix
	private var _transformation : mat4?
	
	/// Contains the stage which the camera captures
	public var stage : GLStage?
	
	/// Returns the matrix for current transformation
	public var transformation : mat4 {
		get {
			if _transformation == nil {
				_transformation = mat4.identity
				_transformation!.rotateX(rad: rx)
				_transformation!.translate(x: -x, y: -y, z: -z)
				_transformation!.rotateY(rad: ry)
				_transformation!.rotate(rad: rz, axis: direction)
			}
			
			return _transformation!
		}
	}
	
	/// Contains the projection matrix of the camera
	public var projection : GLCameraProjection {
		didSet {_transformation = nil}
	}
	
	/// Provides the x position
	public var x : GLfloat = 0 {
		didSet {_transformation = nil}
	}
	
	/// Provides the x position
	public var y : GLfloat = 0 {
		didSet {_transformation = nil}
	}
	
	/// Provides the x position
	public var z : GLfloat = 0 {
		didSet {_transformation = nil}
	}
	
	/// Provides the rotation around x
	public var rx : GLfloat = 0 {
		didSet {_transformation = nil}
	}
	
	/// Provides the rotation around y
	public var ry : GLfloat = 0 {
		didSet {_transformation = nil}
	}
	
	/// Provides the rotation around z
	public var rz : GLfloat = 0 {
		didSet {_transformation = nil}
	}
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the position vector relative to world space origin
	public var position : vec3 {
		get {return vec3(x, y, z)}
		set {
			x = newValue.x
			y = newValue.y
			z = newValue.z
		}
	}
	
	/// Provides the direction in which the camera is looking at
	public var direction : vec3 {
		get {return polar2cartesian(1, theta: ry - Float(M_PI_2), phi: rx)}
	}
	
	/// Provides the up vector of the camera
	public var up : vec3 {
		get {return mat3.makeRotation(rad: rz, axis: direction) * polar2cartesian(1, theta: ry, phi: rx)}
	}
	
	/// Provides the uniforms
	public var uniforms : [GLurl : GLUniform] {
		get {
			return [
				GLUrlCameraViewMatrix : GLuniformMat4fv(transformation),
				GLUrlCameraProjection : GLuniformMat4fv(projection.matrix),
				GLUrlCameraPosition : GLuniform3f(x, y, z),
				GLUrlCameraDirection : GLuniform3f(direction)
			]
		}
	}
	
	
	/**
	Initializes the camera with a given projection
	
	- parameter projection:
	*/
	public init (projection: GLCameraProjection) {
		self.projection = projection
	}
	
	
	/**
	Initializes the camera with a orthographic projection
	*/
	public convenience init () {
		self.init(projection: GLOrthographicProjection(GLvolume()))
	}
	
	
	public func resetTransformation () {
		x = 0; y = 0; z = 0
		rx = 0; ry = 0; rz = 0
	}
}