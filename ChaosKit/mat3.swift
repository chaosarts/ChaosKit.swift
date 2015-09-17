//
//  mat3.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct mat3 : QuadraticMatrix {
	
	// STATIC PROPERTIES
	// +++++++++++++++++
	
	/// Provides the count of elements per rows
	public static var rows : Int {get {return 3}}
	
	/// Provides the count of elements per columns
	public static var cols : Int {get {return 3}}
	
	/// Provides the size of the matrix in byte
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/// Provides the count of elements
	public static var elementCount : Int {get {return rows * cols}}
	
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	// Provides a list of matrix components in column-major represenstation
	public private(set) var array : [GLfloat] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the count of elements per rows
	public var rows : Int {get {return 3}}
	
	/// Provides the count of elements per columns
	public var cols : Int {get {return 3}}
	
	/// Provides the mdterminant of the matrix
	public var determinant : GLfloat {
		
		let a : GLfloat = self[0, 0] * self[1, 1] * self[2, 2] - self[0, 2] * self[1, 1] * self[2, 0]
		let b : GLfloat = self[0, 1] * self[1, 2] * self[2, 0] - self[0, 0] * self[1, 2] * self[2, 1]
		let c : GLfloat = self[0, 2] * self[1, 0] * self[2, 1] - self[0, 1] * self[1, 0] * self[2, 2]
		
		return a + b + c
	}
	
	/// Provides the transposed matrix of the matrix
	public var transposed : mat3 {
		return [
			array[0], array[3], array[6],
			array[1], array[4], array[7],
			array[2], array[5], array[8]
		]
	}
	
	
	// SUBSCRIPTS
	// ++++++++++
	
	/// Array access to row vector
	public subscript (row index: Int) -> vec3 {
		get {
			assert(valid(index), "Bad index access for mat3")
			return vec3(array[index], array[3 + index], array[6 + index])
		}
		
		set {
			assert(valid(index), "Bad index access for mat3")
			array[index] = newValue.x
			array[index + 3] = newValue.y
			array[index + 6] = newValue.z
		}
	}
	
	/// Array access to col vector
	public subscript (col index: Int) -> vec3 {
		get {
			assert(valid(index), "Bad index access for mat3")
			let base : Int = index * 3
			return vec3(array[base], array[base + 1], array[base + 2])
		}
		
		set {
			assert(valid(index), "Bad index access for mat3")
			let base : Int = index * 3
			array[base] = newValue.x
			array[base + 1] = newValue.y
			array[base + 2] = newValue.z
		}
	}
	
	/// Array access to a single component
	public subscript (row: Int, col: Int) -> GLfloat {
		get {
			assert(valid(row) && valid(col), "Bad index access for mat3")
			return array[col * 3 + row]
		}
		
		set {
			assert(valid(row) && valid(col), "Bad index access for mat3")
			array[col * 3 + row] = newValue
		}
	}
	
	
	// INITIALIZERS AND METHODS
	// ++++++++++++++++++++++++
	
	
	/**
	Initializes the zero matrix
	*/
	public init () {}
	
	
	/**
	Initializes the matrix by setting the diaginal with given value.
	
	:param: value
	*/
	public init (_ value: Float) {
		array = [value, 0, 0, 0, value, 0, 0, 0, value]
	}
	
	
	/**
	Initializes the matrix with given array
	
	:param: array
	*/
	public init(_ array: [GLfloat]) {
		for index in 0..<mat3.elementCount {
			self.array[index] = array.count > index ? array[index] : 0
		}
	}
	
	
	/**
	Rotates the matrix by given angle in radians around the axis given by x, y and z
	
	:param: rad The angle in radians
	:param: x The x component of the rotation axis
	:param: y The y component of the rotation axis
	:param: z The z component of the rotation axis
	*/
	public mutating func rotate (rad radian: GLfloat, x rx: GLfloat, y ry: GLfloat, z rz: GLfloat) {
		let mat : [GLfloat] = array
		
		let m00 = mat[0], m10 = mat[1], m20 = mat[2]
		let m01 = mat[3], m11 = mat[4], m21 = mat[5]
		let m02 = mat[6], m12 = mat[7], m22 = mat[8]
		
		let cosAngle = cos(radian)
		let sinAngle = sin(radian)
		let diffCosAngle = 1 - cosAngle
 
		let r00 = rx * rx * diffCosAngle + cosAngle
		let r10 = rx * ry * diffCosAngle + rz * sinAngle
		let r20 = rx * rz * diffCosAngle - ry * sinAngle
		
		let r01 = rx * ry * diffCosAngle - rz * sinAngle
		let r11 = ry * ry * diffCosAngle + cosAngle
		let r21 = ry * rz * diffCosAngle + rx * sinAngle
		
		let r02 = rx * rz * diffCosAngle + ry * sinAngle
		let r12 = ry * rz * diffCosAngle - rx * sinAngle
		let r22 = rz * rz * diffCosAngle + cosAngle
		
		array[0] = m00 * r00 + m01 * r10 + m02 * r20
		array[1] = m10 * r00 + m11 * r10 + m12 * r20
		array[2] = m20 * r00 + m21 * r10 + m22 * r20
	
		array[3] = m00 * r01 + m01 * r11 + m02 * r21
		array[4] = m10 * r01 + m11 * r11 + m12 * r21
		array[5] = m20 * r01 + m21 * r11 + m22 * r21
		
		array[6] = m00 * r02 + m01 * r12 + m02 * r22
		array[7] = m10 * r02 + m11 * r12 + m12 * r22
		array[8] = m20 * r02 + m21 * r12 + m22 * r22
	}
	
	
	/**
	Rotates the matrix by given angle in degrees around the axis given by x, y and z
	
	:param: deg The angle in degrees
	:param: x The x component of the rotation axis
	:param: y The y component of the rotation axis
	:param: z The z component of the rotation axis
	*/
	public mutating func rotate (deg degree: GLfloat, x rx: GLfloat, y ry: GLfloat, z rz: GLfloat) {
		rotate(rad: deg2rad(degree), x: rx, y: ry, z: rz)
	}
	
	
	/**
	Adds a rotation transformation to the matrix around given axis and given angle in radians
	
	:param: rad The angle in radians
	:param: axis The axis to rotate around
	*/
	public mutating func rotate (rad radians: GLfloat, axis: vec3) {
		rotate(rad: radians, x: axis.x, y: axis.y, z: axis.z)
	}
	
	
	/**
	Adds a rotation transformation to the matrix around given axis and given angle in degrees
	
	:param: deg The angle in degrees
	:param: axis The axis to rotate around
	*/
	public mutating func rotate (deg degrees: GLfloat, axis: vec3) {
		rotate(rad: deg2rad(degrees), x: axis.x, y: axis.y, z: axis.z)
	}
	
	
	/**
	Rotates the matrix around the x axis
	
	:param: rad Te anlge in radians
	*/
	public mutating func rotateX (rad radians: GLfloat) {
		let m01 = array[3], m11 = array[4], m21 = array[5]
		let m02 = array[6], m12 = array[7], m22 = array[8]
		
		let c = cos(radians)
		let s = sin(radians)
		
		array[3] = m01 * c + m02 * s
		array[4] = m11 * c + m12 * s
		array[5] = m21 * c + m22 * s
		array[6] = m01 * -s + m02 * c
		array[7] = m11 * -s + m12 * c
		array[8] = m21 * -s + m22 * c
	}
	
	
	/**
	Rotates the matrix around the x axis
	
	:param: deg The anlge in degrees
	*/
	public mutating func rotateX (deg degrees: GLfloat) {
		rotateX(rad: deg2rad(degrees))
	}
	
	
	/**
	Rotates the matrix around the y axis
	
	:param: rad Te anlge in radians
	*/
	public mutating func rotateY (rad radians: GLfloat) {
		let m00 = array[0], m10 = array[1], m20 = array[2]
		let m02 = array[6], m12 = array[7], m22 = array[8]
		
		let c = cos(radians)
		let s = sin(radians)
		
		array[0] = m00 * c + m02 * -s
		array[1] = m10 * c + m12 * -s
		array[2] = m20 * c + m22 * -s
		array[6] = m00 * s + m02 * c
		array[7] = m10 * s + m12 * c
		array[8] = m20 * s + m22 * c
	}
	
	
	/**
	Rotates the matrix around the x axis
	
	:param: deg The anlge in degrees
	*/
	public mutating func rotateY (deg degrees: GLfloat) {
		rotateY(rad: deg2rad(degrees))
	}
	
	
	/**
	Rotates the matrix around the z axis
	
	:param: rad Te anlge in radians
	*/
	public mutating func rotateZ (rad radians: GLfloat) {
		let m00 = array[0], m10 = array[1], m20 = array[2]
  		let m01 = array[3], m11 = array[4], m21 = array[5]
		
		let c = cos(radians)
		let s = sin(radians)
		
		 array[0] = m00 * c + m01 * s
		array[1] = m10 * c + m11 * s
		array[2] = m20 * c + m21 * s
		array[3] = m00 * -s + m01 * c
		array[4] = m10 * -s + m11 * c
		array[5] = m20 * -s + m21 * c
	}
	
	
	/**
	Rotates the matrix around the z axis
	
	:param: deg The anlge in degrees
	*/
	public mutating func rotateZ (deg degrees: GLfloat) {
		rotateZ(rad: deg2rad(degrees))
	}
	
	
	/**
	Determines if the passed is a valid matrix index
	
	:param: index
	:return: bool
	*/
	private func valid(index: Int) -> Bool {
		return index >= 0 && index < 3
	}
}


/*
|--------------------------------------------------------------------------
| Extensions
|--------------------------------------------------------------------------
*/

extension mat3 {
	public static var identity : mat3 {
		get {return mat3(1.0)}
	}
	
	
	public static func makeRotation (rad radians: GLfloat, x: GLfloat, y: GLfloat, z: GLfloat) -> mat3 {
		var mat : mat3 = mat3.identity
		mat.rotate(rad: radians, x: x, y: y, z: z)
		return mat
	}
	
	
	public static func makeRotation (deg degrees: GLfloat, x: GLfloat, y: GLfloat, z: GLfloat) -> mat3 {
		return makeRotation(rad: deg2rad(degrees), x: x, y: y, z: z)
	}
	
	
	public static func makeRotation (rad radians: GLfloat, axis: vec3) -> mat3 {
		return makeRotation(rad: radians, x: axis.x, y: axis.y, z: axis.z)
	}
	
	
	public static func makeRotation (deg degrees: GLfloat, axis: vec3) -> mat3 {
		return makeRotation(rad: deg2rad(degrees), x: axis.x, y: axis.y, z: axis.z)
	}
}


extension mat3 : ArrayLiteralConvertible {
	public init(arrayLiteral elements: GLfloat...) {
		self.init(elements)
	}
}


extension mat3 : Printable {
	public var description : String {get {return toString(self)}}
}


/*
|--------------------------------------------------------------------------
| Operators
|--------------------------------------------------------------------------
*/

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
		dot(l[row: 0], r[col: 0]), dot(l[row: 0], r[col: 1]), dot(l[row: 0], r[col: 2]),
		dot(l[row: 1], r[col: 0]), dot(l[row: 1], r[col: 1]), dot(l[row: 1], r[col: 2]),
		dot(l[row: 2], r[col: 0]), dot(l[row: 2], r[col: 1]), dot(l[row: 2], r[col: 2])
	]
}


public func *(l: mat3, r: vec3) -> vec3 {
	return [dot(l[row: 0], r), dot(l[row: 1], r), dot(l[row: 2], r)]
}


public func *(l: vec3, r: mat3) -> vec3 {
	return r * l
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