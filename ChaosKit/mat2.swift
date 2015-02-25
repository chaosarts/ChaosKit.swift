//
//  mat2.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct mat2 : QuadraticMatrixType {
	
	public static let rows : Int = 2
	
	public static var cols : Int {get {return rows}}
	
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/** The size of a vector */
	public static var elementCount : Int {get {return rows * cols}}
	
	private var _mat : [GLfloat] = [0, 0, 0 ,0]
	
	public var array : [GLfloat] {get {return _mat}}
	
	public var determinant : GLfloat {
		return _mat[0] * _mat[3] - _mat[1] * _mat[2]
	}
	
	public var transposed : mat2 {
		return [_mat[0], _mat[2], _mat[1], _mat[3]]
	}
	
	public var ptr : UnsafeMutablePointer<GLfloat> {
		get {
			var pointer : UnsafeMutablePointer<GLfloat> = UnsafeMutablePointer<GLfloat>.alloc(_mat.count)
			pointer.initializeFrom(_mat)
			return pointer
		}
	}
	
	
	subscript (row index: Int) -> vec2 {
		get {
			assert(valid(index), "Bad index access for mat2")
			return vec2(_mat[2 * index], _mat[2 * index + 1])
		}
		
		set {
			assert(valid(index), "Bad index access for mat2")
			_mat[2 * index] = newValue.x
			_mat[2 * index + 1] = newValue.y
		}
	}
	
	
	subscript (col index: Int) -> vec2 {
		get {
			assert(valid(index), "Bad index access for mat2")
			return vec2(_mat[index], _mat[2 + index])
		}
		
		set {
			assert(valid(index), "Bad index access for mat2")
			_mat[index] = newValue.x
			_mat[2 + index] = newValue.y
		}
	}
	
	
	subscript (row: Int, col: Int) -> GLfloat {
		get {
			assert(valid(row) && valid(col), "Bad index access for mat2")
			return _mat[row * 2 + col]
		}
		
		set {
			assert(valid(row) && valid(col), "Bad index access for mat2")
			_mat[row * 2 + col] = newValue
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
	public init(arrayLiteral elements: GLfloat...) {
		let maximum : Int = min(mat2.elementCount, elements.count)
		_mat = [GLfloat](count: maximum, repeatedValue: 0.0)
		for index in 0..<maximum {
			_mat[index] = elements[index]
		}
	}
}

extension mat2 : ArrayRepresentable {
	public init(_ array: [GLfloat]) {
		for index in 0...3 {
			_mat[index] = array.count > index ? array[index] : 0
		}
	}
}

extension mat2 : Printable {
	public var description : String {
		get {
			var maxlen : Int = 0
			for index in 0...(_mat.count - 1) {
				maxlen = max(maxlen, countElements(_mat[index].description))
			}
			
			maxlen++
			
			var output : String = ""
			let m : mat2 = self
			
			for r in 0...1 {
				output += "|"
				for c in 0...1 {
					var fillLen : Int = maxlen - countElements(m[r, c].description)
					var white : String = " " * UInt32(fillLen)
					output += white + m[r, c].description
				}
				output += "|\n"
			}
			return output
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


public func *(l: mat2, r: GLfloat) -> mat2 {
	return [r * l[0, 0], r * l[0, 1], r * l[1, 0], r * l[1, 1]]
}


public func *(l: GLfloat, r: mat2) -> mat2 {
	return r * l
}