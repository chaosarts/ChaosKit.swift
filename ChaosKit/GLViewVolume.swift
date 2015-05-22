//
//  GLViewVolume.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
View volume struct for camera
*/
public struct GLViewVolume {
	
	/// Provides the left component of the view volume
	public var left : GLfloat = -1
	
	/// Provides the right component of the view volume
	public var right : GLfloat = 1
	
	/// Provides the bottom component of the view volume
	public var bottom : GLfloat = -1
	
	/// Provides the top component of the view volume
	public var top : GLfloat = 1
	
	/// Provides the near component of the view volume
	public var near : GLfloat = 1
	
	/// Provides the far component of the view volume
	public var far : GLfloat = 3
	
	/// Provides the center coordinate of the view volume
	public var center : vec3 {
		get {return vec3(right + left, top + bottom, near + far) * 0.5}
	}
	
	/// Provides the width of the view volume
	public var width : GLfloat {
		get {return abs(right - left)}
		set {var half : GLfloat = newValue / 2; left = center.x - half; right = center.x + half}
	}
	
	/// Provides the height of the view volume
	public var height : GLfloat {
		get {return abs(top - bottom)}
		set {var half : GLfloat = newValue / 2; bottom = center.y - half; top = center.y + half}
	}
	
	/// Provides the depth of the view volume
	public var depth : GLfloat {
		get {return abs(far - near)}
		set {var half : GLfloat = newValue / 2; near = center.z - half; far = center.z + half}
	}
	
	/// Provides the width-height-aspect
	public var aspect : GLfloat {
		get {return width / height}
	}
	
	
	public init () {}
	
	
	public init (left: GLfloat, right: GLfloat, bottom: GLfloat, top: GLfloat, near: GLfloat, far: GLfloat) {
		self.left = left
		self.right = right
		self.bottom = bottom
		self.top = top
		self.near = near
		self.far = far
	}
	
	
	public init (width: GLfloat, height: GLfloat, depth: GLfloat, center: vec3 = vec3(0, 0, 0.1)) {
		let halfWidth : GLfloat = width / 2
		let halfHeight : GLfloat = height / 2
		let z : GLfloat = center.z <= 0 ? 0.1 : center.z
		
		self.left = center.x - halfWidth
		self.right = center.x + halfWidth
		self.bottom = center.y - halfHeight
		self.top = center.y + halfHeight
		self.near = z
		self.far = z + depth
	}
}