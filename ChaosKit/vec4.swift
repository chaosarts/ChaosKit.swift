//
//  vec4.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct vec4 {
	private var vec : (x: CGFloat, y: CGFloat, z: CGFloat, w: CGFloat) = (0, 0, 0, 0)
	
	public var x : CGFloat {
		get {return vec.x} set {vec.x = newValue}
	}
	
	public var y : CGFloat {
		get {return vec.y} set {vec.y = newValue}
	}
	
	public var z : CGFloat {
		get {return vec.z} set {vec.z = newValue}
	}
	
	public var w : CGFloat {
		get {return vec.w} set {vec.w = newValue}
	}
	
	public var array : [CGFloat] {
		return [x, y, z, w]
	}
	
	public var magnitude : CGFloat {
		return sqrt(self * self)
	}
	
	public var normalized : vec4 {
		let m = magnitude
		return vec4(x: x/m, y: y/m, z: z/m, w: w/m)
	}
	
	public init () {
		
	}
	
	public init (x: CGFloat, y: CGFloat, z: CGFloat, w: CGFloat) {
		vec = (x, y, z, w)
	}
	
	public init (v: vec2) {
		vec = (v.x, v.y, 0, 0)
	}
	
	public init (v: vec3) {
		vec = (v.x, v.y, v.z, 0)
	}
}


extension vec4 : ArrayLiteralConvertible {
	public init(arrayLiteral elements: CGFloat...) {
		x = elements.count > 0 ? elements[0] : 0
		y = elements.count > 1 ? elements[1] : 0
		z = elements.count > 2 ? elements[2] : 0
		w = elements.count > 3 ? elements[3] : 0
	}
}


extension vec4 : Equatable {}

public func ==(l: vec4, r: vec4) -> Bool {
	return l.x == r.x && l.y == r.y && l.z == r.z && l.w == r.w
}


public prefix func -(v: vec4) -> vec4 {
	return vec4(x: -v.x, y: -v.y, z: -v.z, w: -v.w)
}


public func +(l: vec4, r: vec4) -> vec4 {
	return vec4(x: l.x + r.x, y: l.y + r.y, z: l.z + r.z, w: l.w + r.w)
}


public func -(l: vec4, r: vec4) -> vec4 {
	return l + -r
}


public func *(l: vec4, r: vec4) -> CGFloat {
	return l.x * r.x + l.y * r.y + l.z * r.z + l.w * r.w
}


public func *(l: vec4, r: CGFloat) -> vec4 {
	return vec4(x: l.x * r, y: l.y * r, z: l.z * r, w: l.w * r)
}


public func *(l: CGFloat, r: vec4) -> vec4 {
	return r * l
}