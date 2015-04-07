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
	public var near : GLfloat = -1
	
	/// Provides the far component of the view volume
	public var far : GLfloat = 1
	
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
}