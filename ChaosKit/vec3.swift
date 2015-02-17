//
//  vec3.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct vec3 : MatrixType {
	public static let rows : UInt = 3
	
	public static let cols : UInt = 1
	
	public static var elementCount : UInt {get {return rows * cols}}
	
	private var vec : (x: GLfloat, y: GLfloat, z: GLfloat) = (0, 0, 0)
	
	public var x : GLfloat {
		get {return vec.x} set {vec.x = newValue}
	}
	
	public var y : GLfloat {
		get {return vec.y} set {vec.y = newValue}
	}
	
	public var z : GLfloat {
		get {return vec.z} set {vec.z = newValue}
	}
	
	public var array : [GLfloat] {
		return [x, y, z]
	}
	
	public var magnitude : GLfloat {
		return sqrt(self * self)
	}
	
	public var normalized : vec3 {
		let m = magnitude
		return vec3(x: x/m, y: y/m, z: z/m)
	}
	
	public init () {
		
	}
	
	public init (x: GLfloat, y: GLfloat, z: GLfloat) {
		vec = (x, y, z)
	}
	
	public init (v: vec2) {
		vec = (v.x, v.y, 0)
	}
	
	subscript (index: Int) -> GLfloat {
		get {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: return x
			case 1: return y
			default: return z
			}
		}
		
		set {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: x = newValue
			case 1: y = newValue
			default: z = newValue
			}
		}
	}
	
	private func valid(index: Int) -> Bool {
		return index >= 0 && index < Int(vec3.elementCount)
	}
}


extension vec3 : ArrayLiteralConvertible {
	public init(arrayLiteral elements: GLfloat...) {
		x = elements.count > 0 ? elements[0] : 0
		y = elements.count > 1 ? elements[1] : 0
		z = elements.count > 2 ? elements[2] : 0
	}
}


extension vec3 : Equatable {}

extension vec3 : Printable {
	public var description : String {get {return "(\(x), \(y), \(z))"}}
}

public func ==(l: vec3, r: vec3) -> Bool {
	return l.x == r.x && l.y == r.y && l.z == r.z
}


public prefix func -(v: vec3) -> vec3 {
	return vec3(x: -v.x, y: -v.y, z: -v.z)
}


public func +(l: vec3, r: vec3) -> vec3 {
	return vec3(x: l.x + r.x, y: l.y + r.y, z: l.z + r.z)
}


public func -(l: vec3, r: vec3) -> vec3 {
	return l + -r
}


public func *(l: vec3, r: vec3) -> GLfloat {
	return l.x * r.x + l.y * r.y + l.z * r.z
}


public func *(l: vec3, r: GLfloat) -> vec3 {
	return vec3(x: l.x * r, y: l.y * r, z: l.z * r)
}


public func *(l: GLfloat, r: vec3) -> vec3 {
	return r * l
}


public func •(l: vec3, r: vec3) -> vec3 {
	return vec3(x: l.y * r.z - l.z * r.y, y: l.z * r.x - l.x * r.z, z: l.x * r.y - l.y * r.x)
}