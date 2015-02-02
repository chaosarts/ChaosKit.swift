//
//  mat2.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct mat2 {
	private var mat : [CGFloat] = [0, 0, 0 ,0]
	
	public var determinant : CGFloat {
		return mat[0] * mat[3] - mat[1] * mat[2]
	}
	
	public var transpose : mat2 {
		return [mat[0], mat[2], mat[1], mat[3]]
	}
	
	
	subscript (row index: Int) -> vec2 {
		get {
			assert(valid(index), "Bad index access for mat2")
			return vec2(x: mat[2 * index], y: mat[2 * index + 1])
		}
		
		set {
			assert(valid(index), "Bad index access for mat2")
			mat[2 * index] = newValue.x
			mat[2 * index + 1] = newValue.y
		}
	}
	
	
	subscript (col index: Int) -> vec2 {
		get {
			assert(valid(index), "Bad index access for mat2")
			return vec2(x: mat[index], y: mat[2 + index])
		}
		
		set {
			assert(valid(index), "Bad index access for mat2")
			mat[index] = newValue.x
			mat[2 + index] = newValue.y
		}
	}
	
	
	subscript (row: Int, col: Int) -> CGFloat {
		get {
			assert(valid(row) && valid(col), "Bad index access for mat2")
			return mat[row * 2 + col]
		}
		
		set {
			assert(valid(row) && valid(col), "Bad index access for mat2")
			mat[row * 2 + col] = newValue
		}
	}
	
	
	public init () {}
	
	
	private func valid (index: Int) -> Bool {
		return index >= 0 && index < 2
	}
}


extension mat2 {
	public static var identity : mat2 {
		get {return [1, 0, 0, 1]}
	}
}


extension mat2 : ArrayLiteralConvertible {
	public init(arrayLiteral elements: CGFloat...) {
		for index in 0...3 {
			mat[index] = elements.count > index ? elements[index] : 0
		}
	}
}


extension mat2 : Equatable {}

public func ==(l: mat2, r: mat2) -> Bool {
	return (l[0, 0] == r[0, 0]) && (l[0, 1] == r[0, 1]) && (l[1, 0] == r[1, 0]) && (l[1, 1] == r[1, 1])
}


public prefix func -(m: mat2) -> mat2 {
	return [-m[0, 0], -m[0, 1], -m[1, 0], -m[1, 1]]
}

public func +(l: mat2, r: mat2) -> mat2 {
	return [l[0, 0] + r[0, 0], l[0, 1] + r[0, 1], l[1, 0] + r[1, 0], l[1, 1] + r[1, 1]]
}


public func -(l: mat2, r: mat2) -> mat2 {
	return l + -r
}


public func *(l: mat2, r: mat2) -> mat2 {
	return [l[row: 0] * r[col: 0], l[row: 0] * r[row: 1], l[row: 1] * r[col: 0], l[row: 1] * r[row: 1]]
}


public func *(l: mat2, r: vec2) -> vec2 {
	return [l[row: 0] * r, l[row: 1] * r]
}


public func *(l: vec2, r: mat2) -> vec2 {
	return [l * r[col: 0], l * r[col: 1]]
}


public func *(l: mat2, r: CGFloat) -> mat2 {
	return [r * l[0, 0], r * l[0, 1], r * l[1, 0], r * l[1, 1]]
}


public func *(l: CGFloat, r: mat2) -> mat2 {
	return r * l
}