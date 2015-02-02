//
//  mat3.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct mat3 {
	
	/** Provides the list of components of this matrix in 
	row-major representation */
	private var mat : [CGFloat] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	
	/** Provides the mdterminant of the matrix */
	public var determinant : CGFloat {
		let m : mat3 = self
		
		let a : CGFloat = m[0, 0] * m[1, 1] * m[2, 2] - m[0, 2] * m[1, 1] * m[2, 0]
		let b : CGFloat = m[0, 1] * m[1, 2] * m[2, 0] - m[0, 0] * m[1, 2] * m[2, 1]
		let c : CGFloat = m[0, 2] * m[1, 0] * m[2, 1] - m[0, 1] * m[1, 0] * m[2, 2]
		
		return a + b + c
	}
	
	/** Provides the transposed matrix of the matrix */
	public var transpose : mat3 {
		return [
			mat[0], mat[3], mat[6],
			mat[1], mat[4], mat[7],
			mat[2], mat[5], mat[8]
		]
	}
	
	/** Array access to row vector */
	subscript (row index: Int) -> vec3 {
		get {
			assert(valid(index), "Bad index access for mat3")
			return vec3(x: mat[index * 4], y: mat[index * 4 + 1], z: mat[index * 4 + 2])
		}
		
		set {
			assert(valid(index), "Bad index access for mat3")
			mat[index * 4] = newValue.x
			mat[index * 4 + 1] = newValue.y
			mat[index * 4 + 2] = newValue.z
		}
	}
	
	/** Array access to col vector */
	subscript (col index: Int) -> vec3 {
		get {
			assert(valid(index), "Bad index access for mat3")
			return vec3(x: mat[index], y: mat[index + 3], z: mat[index + 6])
		}
		
		set {
			assert(valid(index), "Bad index access for mat3")
			mat[index] = newValue.x
			mat[index + 3] = newValue.y
			mat[index + 6] = newValue.z
		}
	}
	
	/** Array access to a single component */
	subscript (row: Int, col: Int) -> CGFloat {
		get {
			assert(valid(row) && valid(col), "Bad index access for mat3")
			return mat[row * 3 + col]
		}
		
		set {
			assert(valid(row) && valid(col), "Bad index access for mat3")
			mat[row * 3 + col] = newValue
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
	public init(arrayLiteral elements: CGFloat...) {
		for index in 0...8 {
			mat[index] = elements.count > index ? elements[index] : 0
		}
	}
}


extension mat3 : Printable {
	public var description : String {
		get {
			var maxlen : Int = 0
			for index in 0...(mat.count - 1) {
				maxlen = max(maxlen, countElements(mat[index].description))
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


public func *(l: CGFloat, r: mat3) -> mat3 {
	return [
		l * r[0, 0], l * r[0, 1], l * r[0, 2],
		l * r[1, 0], l * r[1, 1], l * r[1, 2],
		l * r[2, 0], l * r[2, 1], l * r[2, 2]
	]
}


public func *(l: mat3, r: CGFloat) -> mat3 {
	return r * l
}