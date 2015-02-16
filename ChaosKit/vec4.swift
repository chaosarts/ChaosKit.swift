//
//  vec4.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct vec4 : vector {
	private var vec : (x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat) = (0, 0, 0, 0)
	
	public var x : GLfloat {
		get {return vec.x} set {vec.x = newValue}
	}
	
	public var y : GLfloat {
		get {return vec.y} set {vec.y = newValue}
	}
	
	public var z : GLfloat {
		get {return vec.z} set {vec.z = newValue}
	}
	
	public var w : GLfloat {
		get {return vec.w} set {vec.w = newValue}
	}
	
	public var array : [GLfloat] {
		return [x, y, z, w]
	}
	
	public var magnitude : GLfloat {
		return sqrt(self * self)
	}
	
	public var normalized : vec4 {
		let m = magnitude
		return vec4(x: x/m, y: y/m, z: z/m, w: w/m)
	}
	
	public init () {
		
	}
	
	public init (x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat) {
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
	public init(arrayLiteral elements: GLfloat...) {
		x = elements.count > 0 ? elements[0] : 0
		y = elements.count > 1 ? elements[1] : 0
		z = elements.count > 2 ? elements[2] : 0
		w = elements.count > 3 ? elements[3] : 0
	}
}


extension vec4 : Printable {
	public var description : String {
		get {
			var maxlength = max(countElements(x.description), countElements(y.description), countElements(z.description), countElements(w.description))
			
			var output : String = ""
			var vec : [GLfloat] = self.array
			
			for i in 0...3 {
				output += "|"
				output += ((maxlength - countElements(vec[i].description)) * " ") + vec[i].description
				output += "|\n"
			}
		
			return output
		}
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


public func *(l: vec4, r: vec4) -> GLfloat {
	return l.x * r.x + l.y * r.y + l.z * r.z + l.w * r.w
}


public func *(l: vec4, r: GLfloat) -> vec4 {
	return vec4(x: l.x * r, y: l.y * r, z: l.z * r, w: l.w * r)
}


public func *(l: GLfloat, r: vec4) -> vec4 {
	return r * l
}