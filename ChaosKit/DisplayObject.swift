//
//  DisplayObject.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class DisplayObject {
	/// Provides the translation matrix
	private var _translation : mat4 = mat4.identity
	
	/// Provides the translation matrix
	private var _rotation : mat4 = mat4.identity
	
	/// Contains the scene to which the object belongs to
	public var scene : Scene?
	
	/// Contains the model view matrix
	public final var modelViewMatrix : mat4 {
		get {return _translation * _rotation}
	}
	
	public func translate (x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
		_translation.translate(x: x, y: y, z: z)
	}
	
	public func translate (v: vec3) {
		translate(v.x, v.y, v.z)
	}
	
	public func rotateX (x: GLfloat) {
		_rotation.rotateX(alpha: x)
	}
	
	public func rotateY (y: GLfloat) {
		_rotation.rotateY(alpha: y)
	}
	
	public func rotateZ (z: GLfloat) {
		_rotation.rotateZ(alpha: z)
	}
	
	public init () {}
}

extension DisplayObject : Equatable {}

public func ==(left: DisplayObject, right: DisplayObject) -> Bool {
	return left === right
}
