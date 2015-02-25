//
//  mat3.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct mat3 : QuadraticMatrixType {
	
	public static let rows : Int = 3
	
	public static var cols : Int {get {return rows}}
	
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/** The size of a vector */
	public static var elementCount : Int {get {return rows * cols}}
	
	/** Provides the list of components of this matrix in 
	row-major representation */
	private var _mat : [GLfloat] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	
	public var array : [GLfloat] {get{return _mat}}
	
	/** Provides the mdterminant of the matrix */
	public var determinant : GLfloat {
		let m : mat3 = self
		
		let a : GLfloat = m[0, 0] * m[1, 1] * m[2, 2] - m[0, 2] * m[1, 1] * m[2, 0]
		let b : GLfloat = m[0, 1] * m[1, 2] * m[2, 0] - m[0, 0] * m[1, 2] * m[2, 1]
		let c : GLfloat = m[0, 2] * m[1, 0] * m[2, 1] - m[0, 1] * m[1, 0] * m[2, 2]
		
		return a + b + c
	}
	
	/** Provides the transposed matrix of the matrix */
	public var transposed : mat3 {
		return [
			_mat[0], _mat[3], _mat[6],
			_mat[1], _mat[4], _mat[7],
			_mat[2], _mat[5], _mat[8]
		]
	}
	
	/** Array access to row vector */
	subscript (row index: Int) -> vec3 {
		get {
			assert(valid(index), "Bad index access for mat3")
			return vec3(_mat[index], _mat[3 + index], _mat[6 + index])
		}
		
		set {
			assert(valid(index), "Bad index access for mat3")
			_mat[index] = newValue.x
			_mat[index + 3] = newValue.y
			_mat[index + 6] = newValue.z
		}
	}
	
	/** Array access to col vector */
	subscript (col index: Int) -> vec3 {
		get {
			assert(valid(index), "Bad index access for mat3")
			return vec3(_mat[index * 3], _mat[index * 3 + 1], _mat[index * 3 + 2])
		}
		
		set {
			assert(valid(index), "Bad index access for mat3")
			_mat[index * 3] = newValue.x
			_mat[index * 3 + 1] = newValue.y
			_mat[index * 3 + 2] = newValue.z
		}
	}
	
	/** Array access to a single component */
	subscript (row: Int, col: Int) -> GLfloat {
		get {
			assert(valid(row) && valid(col), "Bad index access for mat3")
			return _mat[col * 3 + row]
		}
		
		set {
			assert(valid(row) && valid(col), "Bad index access for mat3")
			_mat[col * 3 + row] = newValue
		}
	}
	
	public init () {}
	
	
	/** Determines if the passed is a valid matrix index */
	private func valid(index: Int) -> Bool {
		return index >= 0 && index < 3
	}
}


extension mat3 {
	public static var identity : mat3 {
		get {return [1, 0, 0, 0, 1, 0, 0, 0, 1]}
	}
}


extension mat3 : ArrayLiteralConvertible {
	public init(arrayLiteral elements: GLfloat...) {
		let maximum : Int = min(mat3.elementCount, elements.count)
		_mat = [GLfloat](count: maximum, repeatedValue: 0.0)
		for index in 0..<maximum {
			_mat[index] = elements[index]
		}
	}
}


extension mat3 : ArrayRepresentable {
	public init(_ array: [GLfloat]) {
		for index in 0..<mat3.elementCount {
			_mat[index] = array.count > index ? array[index] : 0
		}
	}
}


extension mat3 : Printable {
	public var description : String {
		get {
			var maxlen : Int = 0
			for index in 0...(_mat.count - 1) {
				maxlen = max(maxlen, countElements(_mat[index].description))
			}
			
			maxlen++
			
			var output : String = ""
			let m : mat3 = self
			
			for r in 0...2 {
				output += "|"
				for c in 0...2 {
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


extension mat3 : Equatable {}

public func ==(l: mat3, r: mat3) -> Bool {
	for var i = l.array.count - 1; i >= 0; i-- {
		if l.array[i] != r.array[i] {return false}
	}
	
	return true
}


public prefix func -(m: mat3) -> mat3 {
	return [
		-m[0, 0], -m[0, 1], -m[0, 2],
		-m[1, 0], -m[1, 1], -m[1, 2],
		-m[2, 0], -m[2, 1], -m[2, 2]
	]
}


public func +(l: mat3, r: mat3) -> mat3 {
	return [
		l[0, 0] + r[0, 0], l[0, 1] + r[0, 1], l[0, 2] + r[0, 2],
		l[1, 0] + r[1, 0], l[1, 1] + r[1, 1], l[1, 2] + r[1, 2],
		l[2, 0] + r[2, 0], l[2, 1] + r[2, 1], l[2, 2] + r[2, 2]
	]
}


public func -(l: mat3, r: mat3) -> mat3 {
	return l + -r
}


public func *(l: mat3, r: mat3) -> mat3 {
	return [
		l[row: 0] * r[col: 0], l[row: 0] * r[col: 1], l[row: 0] * r[col: 2],
		l[row: 1] * r[col: 0], l[row: 1] * r[col: 1], l[row: 1] * r[col: 2],
		l[row: 2] * r[col: 0], l[row: 2] * r[col: 1], l[row: 2] * r[col: 2],
	]
}


public func *(l: mat3, r: vec3) -> vec3 {
	return [l[row: 0] * r, l[row: 1] * r, l[row: 2] * r]
}


public func *(l: vec3, r: mat3) -> vec3 {
	return [l * r[col: 0], l * r[col: 1], l * r[col: 2]]
}


public func *(l: GLfloat, r: mat3) -> mat3 {
	return [
		l * r[0, 0], l * r[0, 1], l * r[0, 2],
		l * r[1, 0], l * r[1, 1], l * r[1, 2],
		l * r[2, 0], l * r[2, 1], l * r[2, 2]
	]
}


public func *(l: mat3, r: GLfloat) -> mat3 {
	return r * l
}