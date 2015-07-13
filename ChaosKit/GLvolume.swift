//
//  GLvolume.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/*
|--------------------------------------------------------------------------
| Volume struct
|--------------------------------------------------------------------------
*/

/**
Volume struct. Can be used to define the view colume of a camera
*/
public struct GLvolume {
	
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
	
	
	/// Initializes the volume with default values
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
		
		self.init(
			left: center.x - halfWidth, right: center.x + halfWidth, bottom: center.y - halfHeight,
			top: center.y + halfHeight, near: z, far: z + depth
		)
	}
}


extension GLvolume : ArrayLiteralConvertible {
	public init (arrayLiteral elements: GLfloat...) {
		var defaults : [GLfloat] = [-1, 1, -1, 1, 1, 3]
		var count : Int = min(defaults.count, elements.count)
		for i in 0..<count {
			defaults[i] = elements[i]
		}
		
		self.init(left: defaults[0], right: defaults[1], bottom: defaults[2], top: defaults[3], near: defaults[4], far: defaults[5])
	}
}


/*
|--------------------------------------------------------------------------
| Volume function
|--------------------------------------------------------------------------
*/


typealias glVolumeUpdater = (winWidth: GLfloat, winHeight: GLfloat, baseVolume: GLvolume, currentVolume: GLvolume) -> GLvolume


public func glKeepVolumeWidth (winWidth: GLfloat, winHeight: GLfloat, baseVolume: GLvolume, currentVolume: GLvolume) -> GLvolume {
	var volume : GLvolume = baseVolume
	let winAspect : GLfloat = winWidth / winHeight
	let halfHeight : GLfloat = (baseVolume.width / winAspect) / 2.0
	
	volume.bottom = -halfHeight
	volume.top = halfHeight
	
	return volume
//	return GLvolume(left: baseVolume.left, right: baseVolume.right, bottom: -halfHeight,
//		top: halfHeight, near: baseVolume.near, far: baseVolume.far)
}


public func glKeepVolumeHeight (winWidth: GLfloat, winHeight: GLfloat, baseVolume: GLvolume, currentVolume: GLvolume) -> GLvolume {
	var volume : GLvolume = baseVolume
	let winAspect : GLfloat = winWidth / winHeight
	let halfWidth : GLfloat = (baseVolume.height * winAspect) / 2.0
	
	volume.left = -halfWidth
	volume.right = halfWidth
	return volume
//	return GLvolume(left: -halfWidth, right: halfWidth, bottom: -baseVolume.bottom,
//		top: baseVolume.top, near: baseVolume.near, far: baseVolume.far)
}


public func glKeepWholeScene (winWidth: GLfloat, winHeight: GLfloat, baseVolume: GLvolume, currentVolume: GLvolume) -> GLvolume {
	var volume = baseVolume
	let winAspect : GLfloat = winWidth / winHeight
	
	if winAspect > baseVolume.width / baseVolume.height {
		volume = glKeepVolumeHeight(winWidth, winHeight, baseVolume, currentVolume)
	}
	else {
		volume = glKeepVolumeWidth(winWidth, winHeight, baseVolume, currentVolume)
	}
	return volume
}