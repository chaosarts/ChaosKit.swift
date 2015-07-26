//
//  vec4.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct vec4 : Vector {
	public static let rows : Int = 4
	
	public static let cols : Int = 1
	
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/** The size of a vector */
	public static var elementCount : Int {get {return rows * cols}}
	
	private var _vec : (x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat) = (0, 0, 0, 0)
	
	
	public var x : GLfloat {
		get {return _vec.x} set {_vec.x = newValue}
	}
	
	public var y : GLfloat {
		get {return _vec.y} set {_vec.y = newValue}
	}
	
	public var z : GLfloat {
		get {return _vec.z} set {_vec.z = newValue}
	}
	
	public var w : GLfloat {
		get {return _vec.w} set {_vec.w = newValue}
	}
	
	/// The xy components as vec2
	public var xx : vec2 {
		get {return vec2(_vec.x, _vec.x)}
	}
	
	/// The xy components as vec2
	public var xy : vec2 {
		get {return vec2(_vec.x, _vec.y)}
	}
	
	/// The xy components as vec2
	public var xz : vec2 {
		get {return vec2(_vec.x, _vec.z)}
	}
	
	/// The xy components as vec2
	public var yx : vec2 {
		get {return vec2(_vec.y, _vec.x)}
	}
	
	/// The xy components as vec2
	public var yy : vec2 {
		get {return vec2(_vec.y, _vec.y)}
	}
	
	/// The xy components as vec2
	public var yz : vec2 {
		get {return vec2(_vec.y, _vec.z)}
	}
	
	/// The xy components as vec2
	public var zx : vec2 {
		get {return vec2(_vec.z, _vec.x)}
	}
	
	/// The xy components as vec2
	public var zy : vec2 {
		get {return vec2(_vec.z, _vec.y)}
	}
	
	/// The xy components as vec2
	public var zz : vec2 {
		get {return vec2(_vec.z, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xxx : vec3 {
		get {return vec3(_vec.x, _vec.x, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xxy : vec3 {
		get {return vec3(_vec.x, _vec.x, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xxz : vec3 {
		get {return vec3(_vec.x, _vec.x, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xxw : vec3 {
		get {return vec3(_vec.x, _vec.x, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xyx : vec3 {
		get {return vec3(_vec.x, _vec.y, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xyy : vec3 {
		get {return vec3(_vec.x, _vec.y, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xyz : vec3 {
		get {return vec3(_vec.x, _vec.y, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xyw : vec3 {
		get {return vec3(_vec.x, _vec.y, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xzx : vec3 {
		get {return vec3(_vec.x, _vec.z, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xzy : vec3 {
		get {return vec3(_vec.x, _vec.z, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xzz : vec3 {
		get {return vec3(_vec.x, _vec.z, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xzw : vec3 {
		get {return vec3(_vec.x, _vec.z, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xwx : vec3 {
		get {return vec3(_vec.x, _vec.w, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xwy : vec3 {
		get {return vec3(_vec.x, _vec.w, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xwz : vec3 {
		get {return vec3(_vec.x, _vec.w, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xww : vec3 {
		get {return vec3(_vec.x, _vec.w, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yxx : vec3 {
		get {return vec3(_vec.y, _vec.x, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yxy : vec3 {
		get {return vec3(_vec.y, _vec.x, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yxz : vec3 {
		get {return vec3(_vec.y, _vec.x, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yxw : vec3 {
		get {return vec3(_vec.y, _vec.x, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yyx : vec3 {
		get {return vec3(_vec.y, _vec.y, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yyy : vec3 {
		get {return vec3(_vec.y, _vec.y, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yyz : vec3 {
		get {return vec3(_vec.y, _vec.y, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yyw : vec3 {
		get {return vec3(_vec.y, _vec.y, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yzx : vec3 {
		get {return vec3(_vec.y, _vec.z, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yzy : vec3 {
		get {return vec3(_vec.y, _vec.z, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yzz : vec3 {
		get {return vec3(_vec.y, _vec.z, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yzw : vec3 {
		get {return vec3(_vec.y, _vec.z, _vec.w)}
	}

	/// Selector to return a vec3 with components as the varname is written
	public var ywx : vec3 {
		get {return vec3(_vec.y, _vec.w, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var ywy : vec3 {
		get {return vec3(_vec.y, _vec.w, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var ywz : vec3 {
		get {return vec3(_vec.y, _vec.w, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yww : vec3 {
		get {return vec3(_vec.y, _vec.w, _vec.w)}
	}

	/// Selector to return a vec3 with components as the varname is written
	public var zxx : vec3 {
		get {return vec3(_vec.z, _vec.x, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zxy : vec3 {
		get {return vec3(_vec.z, _vec.x, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zxz : vec3 {
		get {return vec3(_vec.z, _vec.x, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zxw : vec3 {
		get {return vec3(_vec.z, _vec.x, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zyx : vec3 {
		get {return vec3(_vec.z, _vec.y, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zyy : vec3 {
		get {return vec3(_vec.z, _vec.y, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zyz : vec3 {
		get {return vec3(_vec.z, _vec.y, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zyw : vec3 {
		get {return vec3(_vec.z, _vec.y, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zzx : vec3 {
		get {return vec3(_vec.z, _vec.z, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zzy : vec3 {
		get {return vec3(_vec.z, _vec.z, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zzz : vec3 {
		get {return vec3(_vec.z, _vec.z, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zzw : vec3 {
		get {return vec3(_vec.z, _vec.z, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zwx : vec3 {
		get {return vec3(_vec.z, _vec.w, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zwy : vec3 {
		get {return vec3(_vec.z, _vec.w, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zwz : vec3 {
		get {return vec3(_vec.z, _vec.w, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zww : vec3 {
		get {return vec3(_vec.z, _vec.w, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wxx : vec3 {
		get {return vec3(_vec.w, _vec.x, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wxy : vec3 {
		get {return vec3(_vec.w, _vec.x, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wxz : vec3 {
		get {return vec3(_vec.w, _vec.x, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wxw : vec3 {
		get {return vec3(_vec.w, _vec.x, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wyx : vec3 {
		get {return vec3(_vec.w, _vec.y, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wyy : vec3 {
		get {return vec3(_vec.w, _vec.y, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wyz : vec3 {
		get {return vec3(_vec.w, _vec.y, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wyw : vec3 {
		get {return vec3(_vec.w, _vec.y, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wzx : vec3 {
		get {return vec3(_vec.w, _vec.z, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wzy : vec3 {
		get {return vec3(_vec.w, _vec.z, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wzz : vec3 {
		get {return vec3(_vec.w, _vec.z, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wzw : vec3 {
		get {return vec3(_vec.w, _vec.z, _vec.w)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wwx : vec3 {
		get {return vec3(_vec.w, _vec.w, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wwy : vec3 {
		get {return vec3(_vec.w, _vec.w, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var wwz : vec3 {
		get {return vec3(_vec.w, _vec.w, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var www : vec3 {
		get {return vec3(_vec.w, _vec.w, _vec.w)}
	}
	
	public var array : [GLfloat] {
		return [x, y, z, w]
	}
	
	public var magnitude : GLfloat {
		return sqrt(dot(self, self))
	}
	
	public var normalized : vec4 {
		let m = magnitude
		return vec4(x/m, y/m, z/m, w/m)
	}
	
	public init () {
		
	}
	
	public init (_ x: GLfloat, _ y: GLfloat, _ z: GLfloat, _ w: GLfloat) {
		_vec = (x, y, z, w)
	}
	
	public init (_ v: vec2) {
		_vec = (v.x, v.y, 0, 0)
	}
	
	public init (_ v: vec3) {
		_vec = (v.x, v.y, v.z, 0)
	}
	
	
	public init(_ array: [GLfloat]) {
		x = array.count > 0 ? array[0] : 0
		y = array.count > 1 ? array[1] : 0
		z = array.count > 2 ? array[2] : 0
		w = array.count > 3 ? array[3] : 0
	}
	
	subscript (index: Int) -> GLfloat {
		get {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: return x
			case 1: return y
			case 2: return z
			default: return w
			}
		}
		
		set {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: x = newValue
			case 1: y = newValue
			case 2: z = newValue
			default: w = newValue
			}
		}
	}
	
	private func valid(index: Int) -> Bool {
		return index >= 0 && index < Int(vec4.elementCount)
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
	public var description : String {get {return "(\(x), \(y), \(z), \(w))"}}
}


extension vec4 : Equatable {}

public func ==(l: vec4, r: vec4) -> Bool {
	return l.x == r.x && l.y == r.y && l.z == r.z && l.w == r.w
}


public prefix func -(v: vec4) -> vec4 {
	return vec4(-v.x, -v.y, -v.z, -v.w)
}


public func +(l: vec4, r: vec4) -> vec4 {
	return vec4(l.x + r.x, l.y + r.y, l.z + r.z, l.w + r.w)
}


public func -(l: vec4, r: vec4) -> vec4 {
	return l + -r
}


public func *(l: vec4, r: vec4) -> vec4 {
	return vec4(l.x * r.x, l.y * r.y, l.z * r.z, l.w * r.w)
}


public func *(l: vec4, r: GLfloat) -> vec4 {
	return vec4(l.x * r, l.y * r, l.z * r, l.w * r)
}


public func *(l: GLfloat, r: vec4) -> vec4 {
	return r * l
}

public func dot(l: vec4, r: vec4) -> GLfloat {
	let a : GLfloat = l.x * r.x + l.y * r.y
	let b : GLfloat = l.z * r.z + l.w * r.w
	return a + b
}


public func gramschmidt (a: vec4, b: vec4, c: vec4, d: vec4) -> [vec4] {
	let x : vec4 = a
	let xdot : Float = dot(x, x)
	
	let y : vec4 = b - (dot(x, b) / xdot) * x
	let ydot : Float = dot(y, y)
	
	let z : vec4 = c - (dot(x, c) / xdot) * x - (dot(y, c) / ydot) * y
	
	let w : vec4 = d - (dot(x, d) / xdot) * x - (dot(y, d) / ydot) * y - (dot(z, d) / dot(z, z)) * z
	return [x, y, z, w]
}