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
	private var _modelViewMatrix : mat4?
	
	/// Caches the uniforms
	private var _uniforms : [GLUrl : GLUniform]?
	
	/// Contains the stage which the camera captures
	public var stage : GLStage?
	
	/// Contains the projection matrix of the camera
	public var projection : GLCameraProjection
	
	/// Contains the position of the camera
	public var position : vec3 = vec3(0, 0, 1) {didSet {_modelViewMatrix = nil}}
	
	/// Contains the rotation
	public var rotation : vec3 = vec3 () {didSet {_modelViewMatrix = nil}}
	
	/// Provides the up vector of the camera
	public var up : vec3 = vec3(0, 1, 0) {didSet {_modelViewMatrix = nil}}
	
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
			if _modelViewMatrix == nil {
				_modelViewMatrix = mat4.makeRotationX(deg: -rotation.x)
				_modelViewMatrix!.rotateY(deg: -rotation.y)
				_modelViewMatrix!.rotateZ(deg: -rotation.z)
				_modelViewMatrix!.translate(-position)
			}
			
			return _modelViewMatrix!
		}
	}
	
	
	/// Provides the uniforms
	public var uniforms : [GLUrl : GLUniform] {
		get {
			if _uniforms == nil {
				_uniforms = [
					GLUrl(.Camera, .Transformation) : GLUniformMatrix4fv(modelViewMatrix),
					GLUrl(.Camera, .Projection) : GLUniformMatrix4fv(projection.matrix)
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
	
	
	/**
	Rotates the camera to a given position
	
	:param: position
	*/
	public func lookAt (position: vec3) {
		
	}
}