//
//  mat2.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Struct for 2x2 matrix (column major)
*/
public struct mat2 : QuadraticMatrix {
	
	// STATIC PROPERTIES
	// +++++++++++++++++
	
	/// Provides the row count of the matrix
	public static let rows : Int = 2
	
	/// Provides the col count of the matrix
	public static var cols : Int {get {return rows}}
	
	/// Provides the size of the matrix in bytes
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/// Provides the count of components
	public static var elementCount : Int {get {return rows * cols}}
	
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides the matrix as array
	public private(set) var array : [GLfloat] = [0, 0, 0 ,0]
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the determinant of the matrix
	public var determinant : GLfloat {
		return array[0] * array[3] - array[1] * array[2]
	}
	
	/// Provides the transposed matrix
	public var transposed : mat2 {
		return [array[0], array[2], array[1], array[3]]
	}
	
	
	// SUBSCRIPTS
	// ++++++++++
	
	/**
	Returns the row at given index.
	
	:param: row The zero based row index to access. Must be either 0 or 1
	*/
	subscript (row index: Int) -> vec2 {
		get {
			assert(valid(index), "Bad index access for mat2")
			return vec2(array[2 * index], array[2 * index + 1])
		}
		
		set {
			assert(valid(index), "Bad index access for mat2")
			array[2 * index] = newValue.x
			array[2 * index + 1] = newValue.y
		}
	}
	
	
	/**
	Returns the column at given index.
	
	:param: row The zero based column index to access. Must be either 0 or 1
	*/
	subscript (col index: Int) -> vec2 {
		get {
			assert(valid(index), "Bad index access for mat2")
			return vec2(array[index], array[2 + index])
		}
		
		set {
			assert(valid(index), "Bad index access for mat2")
			array[index] = newValue.x
			array[2 + index] = newValue.y
		}
	}
	
	
	/**
	Returns the value of the component of the matrix at given row and column index (zero based)
	
	:param: row The row index
	:param: col The column index
	:return: The value of the according component
	*/
	subscript (row: Int, col: Int) -> GLfloat {
		get {
			assert(valid(row) && valid(col), "Bad index access for mat2")
			return array[row * 2 + col]
		}
		
		set {
			assert(valid(row) && valid(col), "Bad index access for mat2")
			array[row * 2 + col] = newValue
		}
	}
	
	/**
	Initializes the matrix as zero matrix
	*/
	public init () {}
	
	
	/**
	Initializes a diagonal matrix with given value on the (i, i) index
	
	:param: value The value to use for the diagonal components
	*/
	public init (_ value: GLfloat) {
		array = [value, 0.0, 0.0, value]
	}
	
	
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
		array = [GLfloat](count: maximum, repeatedValue: 0.0)
		for index in 0..<maximum {
			array[index] = elements[index]
		}
	}
}

extension mat2 : ArrayRepresentable {
	public init(_ array: [GLfloat]) {
		for index in 0...3 {
			self.array[index] = array.count > index ? array[index] : 0
		}
	}
}

extension mat2 : Printable {
	public var description : String {
		get {
			var maxlen : Int = 0
			for index in 0...(array.count - 1) {
				maxlen = max(maxlen, count(array[index].description))
			}
			
			maxlen++
			
			var output : String = ""
			let m : mat2 = self
			
			for r in 0...1 {
				output += "|"
				for c in 0...1 {
					var fillLen : Int = maxlen - count(m[r, c].description)
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