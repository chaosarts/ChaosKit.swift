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
public class GLCamera {
	
	/// Caches the model view matrix
	private var _cache : mat4?
	
	/// Contains the stage which the camera captures
	public var stage : GLStage?
	
	/// Contains the projection matrix of the camera
	public var projection : GLCameraProjection
	
	/// Contains the position of the camera
	public var position : vec3 = vec3() {didSet {_cache = nil}}
	
	/// Contains the rotation
	public var rotation : vec3 = vec3 () {didSet {_cache = nil}}
	
	/// Provides the vector (global) in which the camera is directed
	public var direction : vec3 = vec3 () {didSet {_cache = nil}}
	
	/// Provides the up vector of the camera
	public var up : vec3 = vec3(0, 1, 0) {didSet {_cache = nil}}
	
	/// Contains the x position of the camera
	public var x : GLfloat {
		get {return position.x}
		set {position.x = newValue}
	}
	
	/// Contains the y position of the camera
	public var y : GLfloat {
		get {return position.y}
		set {position.y = newValue}
	}
	
	/// Contains the z position of the camera
	public var z : GLfloat {
		get {return position.z}
		set {position.z = newValue}
	}
	
	/// Provides the model view matrix generated according to position
	/// and watch direction of the camera
	public var modelViewMatrix : mat4 {
		get {
			if _cache == nil {
				_cache = mat4.makeRotationX(deg: -rotation.x)
				_cache!.rotateY(deg: -rotation.y)
				_cache!.rotateZ(deg: -rotation.z)
				_cache!.translate(-position)
			}
			
			return _cache!
		}
	}
	
	
	public init (projection: GLCameraProjection) {
		self.projection = projection
	}
	
	
	public convenience init () {
		self.init(projection: GLOrthographicProjection(viewVolume: GLViewVolume()))
	}
	
	
	public func lookAt (position: vec3) {
		polar2cartesian(1, rotation.z * GLfloat(M_PI / 180.0), rotation.y * GLfloat(M_PI / 180.0))
	}
}