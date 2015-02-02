//
//  vec2.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct vec2 {
	private var vec : (x: CGFloat, y: CGFloat) = (0, 0)
	
	public var x: CGFloat {
		get {return vec.x} set {vec.x = newValue}
	}
	
	public var y: CGFloat {
		get {return vec.y} set {vec.y = newValue}
	}
	
	public var array : [CGFloat] {
		get {return [x, y]}
	}
	
	public var magnitude : CGFloat {
		return sqrt(self * self)
	}
	
	public var normal : vec2 {
		return vec2(x: -y, y: x)
	}
	
	public var normalized : vec2 {
		var m : CGFloat = magnitude
		return vec2(x: x / m, y: y / m)
	}
	
	public init () {}
	
	public init (x: CGFloat, y: CGFloat) {
		vec = (x, y)
	}
	
	subscript (index: Int) -> CGFloat {
		get {
			assert(valid(index), "Bad index access for vec2")
			return index == 0 ? x : y
		}
		
		set {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: x = newValue
			default: y = newValue
			}
		}
	}
	
	private func valid(index: Int) -> Bool {
		return index == 0 || index == 1
	}
}

extension vec2 : ArrayLiteralConvertible {
	public init(arrayLiteral elements: CGFloat...) {
		x = elements.count > 0 ? elements[0] : 0
		y = elements.count > 1 ? elements[1] : 0
	}
}

extension vec2 : Equatable {}

public func ==(l: vec2, r: vec2) -> Bool {
	return l.x == r.x && l.y == r.y
}

extension vec2 : Printable {
	public var description : String {
		get {return "(\(x), \(y))"}
	}
}


public prefix func -(v: vec2) -> vec2 {
	return vec2(x: -v.x, y: -v.y)
}


public func +(l: vec2, r: vec2) -> vec2 {
	return vec2(x: l.x + r.x, y: l.y + r.y)
}


public func -(l: vec2, r: vec2) -> vec2 {
	return l + -r
}


public func *(l: vec2, r: vec2) -> CGFloat {
	return l.x * r.x + l.y * r.y
}


public func *(l: CGFloat, r: vec2) -> vec2 {
	return vec2(x: l * r.x, y: l * r.y)
}


public func *(l: vec2, r: CGFloat) -> vec2 {
	return r * l
}