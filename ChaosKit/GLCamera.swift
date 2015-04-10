//
//  GLCamera.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/** 
*/
public class GLCamera {
	
	private var _cache : mat4?
	
	public var projection : GLCameraProjection
	
	public var position : vec3 = vec3() {
		didSet {_cache = nil}
	}
	
	public var rotation : vec3 = vec3 () {
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
	
	public var projectionViewMatrix : mat4 {
		get {return projection.viewMatrix}
	}
	
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