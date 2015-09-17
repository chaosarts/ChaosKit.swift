//
//  mat4.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct mat4 : QuadraticMatrix {
	
	// STATIC PROPERTIES
	// +++++++++++++++++
	
	/// Provides the count of elements per rows
	public static var rows : Int {get {return 4}}
	
	/// Provides the count of elements per columns
	public static var cols : Int {get {return 4}}
	
	/// Provides the size of the matrix in byte
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/// Provides the count of elements
	public static var elementCount : Int {get {return rows * cols}}
	
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	// Provides a list of matrix components in major-row represenstation
	public private(set) var array : [GLfloat] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the count of elements per rows
	public var rows : Int {get {return 4}}
	
	/// Provides the count of elements per columns
	public var cols : Int {get {return 4}}
	
	/// Provides the determinant of the matrix
	public var determinant : GLfloat {
		let m : mat4 = self
		
		let row : vec4 = m[row: 0]
		
		let a : GLfloat = row.x * submatrix(row: 0, col: 0).determinant
		let b : GLfloat = row.y * submatrix(row: 0, col: 1).determinant
		let c : GLfloat = row.z * submatrix(row: 0, col: 2).determinant
		let d : GLfloat = row.w * submatrix(row: 0, col: 3).determinant
		
		return a - b + c - d
	}
	
	/// Provides the transposed matrix of this matrix
	public var transposed : mat4 {
		let m : mat4 = self
		return [
			m[0, 0], m[1, 0], m[2, 0], m[3, 0],
			m[0, 1], m[1, 1], m[2, 1], m[3, 1],
			m[0, 2], m[1, 2], m[2, 2], m[3, 2],
			m[0, 3], m[1, 3], m[2, 3], m[3, 3]
		]
	}
	
	
	// SUBSCRIPTS
	// ++++++++++
	
	/// Subscript access for row vectors
	public subscript(row index: Int) -> vec4 {
		get {
			assert(valid(index), "Invalid mat4 index access.")
			return vec4(array[index], array[index + 4], array[index + 8], array[index + 12])
		}
		
		set {
			assert(valid(index), "Invalid mat4 index access.")
			array[index] = newValue.x
			array[index + 4] = newValue.y
			array[index + 8] = newValue.z
			array[index + 12] = newValue.w
		}
	}
	
	/// Array access for column vectors
	public subscript(col index: Int) -> vec4 {
		get {
		assert(valid(index), "Invalid mat4 index access.")
		let base : Int = index * 4
		return vec4(array[base], array[base + 1], array[base + 2], array[base + 3])
		}
		
		set {
			assert(valid(index), "Invalid mat4 index access.")
			let base : Int = index * 4
			array[base] = newValue.x
			array[base + 1] = newValue.y
			array[base + 2] = newValue.z
			array[base + 3] = newValue.w
		}
	}
	
	/// Array access for single components
	public subscript(row: Int, col: Int) -> GLfloat {
		get {
			assert(valid(row) && valid(col), "Invalid mat4 index access.")
			return array[col * 4 + row]
		}
		
		set {
			assert(valid(row) && valid(col), "Invalid mat4 index access.")
			array[col * 4 + row] = newValue
		}
	}
	
	
	// INITIALIZERS AND METHODS
	// ++++++++++++++++++++++++
	
	/**
	Default initializer. Fills the matrix with zeros
	*/
	public init () {}
	
	
	/**
	Returns the submatrix by removing a row and column at given indices
	
	- parameter row: The row index to remove
	- parameter col: The col index to remove
	*/
	public func submatrix(row rowIndex: Int, col colIndex: Int) -> mat3 {
		assert(valid(rowIndex) && valid(colIndex), "Bad index access for mat4")
		
		var m : [GLfloat] = []
		for r in 0..<mat4.rows {
			for c in 0..<mat4.cols {
				if r == rowIndex || c == colIndex {continue}
				m.append(array[c * 4 + r])
			}
		}
		
		return mat3(m)
	}
	
	
	/**
	Rotates the matrix around an arbitrary axis, given by vec
	
	- parameter alpha: The angle to rotate about
	- parameter vec: The axis to rotate around
	*/
	mutating public func rotate (deg degree: GLfloat, axis: vec3) {
		rotate(deg: degree, x: axis.x, y: axis.y, z: axis.z)
	}
	
	
	/**
	Rotates the matrix around an arbitrary axis, given by vec
	
	- parameter alpha: The angle to rotate about
	- parameter vec: The axis to rotate around
	*/
	mutating public func rotate (rad radian: GLfloat, axis: vec3) {
		rotate(rad: radian, x: axis.x, y: axis.y, z: axis.z)
	}
	
	
	/**
	Rotates the matrix around an arbitrary axis, given by the vector components
	
	- parameter alpha: The angle to rotate about
	- parameter vec: The axis to rotate around
	*/
	mutating public func rotate (deg degree: GLfloat, x dx: GLfloat, y dy: GLfloat, z dz: GLfloat) {
		let radian : GLfloat = deg2rad(degree)
		rotate(rad: radian, x: dx, y: dy, z: dz)
	}
	
	
	/**
	Rotates the matrix around an arbitrary axis, given by the vector components
	
	- parameter alpha: The angle to rotate about
	- parameter vec: The axis to rotate around
	*/
	mutating public func rotate (rad radian: GLfloat, x dx: GLfloat, y dy: GLfloat, z dz: GLfloat) {
		let m00 = array[0], m10 = array[1], m20 = array[2], m30 = array[3]
		let m01 = array[4], m11 = array[5], m21 = array[6], m31 = array[7]
		let m02 = array[8], m12 = array[9], m22 = array[10], m32 = array[11]
		let m03 = array[12], m13 = array[13], m23 = array[14], m33 = array[15]
		
		let cosAngle = cos(radian)
		let sinAngle = sin(radian)
		let diffCosAngle = 1 - cosAngle
		
		let r00 = dx * dx * diffCosAngle + cosAngle
		let r10 = dx * dy * diffCosAngle + dz * sinAngle
		let r20 = dx * dz * diffCosAngle - dy * sinAngle
		
		let r01 = dx * dy * diffCosAngle - dz * sinAngle
		let r11 = dy * dy * diffCosAngle + cosAngle
		let r21 = dy * dz * diffCosAngle + dx * sinAngle
		
		let r02 = dx * dz * diffCosAngle + dy * sinAngle
		let r12 = dy * dz * diffCosAngle - dx * sinAngle
		let r22 = dz * dz * diffCosAngle + cosAngle
		
		
		array[0]  = m00 * r00 + m01 * r10 + m02 * r20
		array[1]  = m10 * r00 + m11 * r10 + m12 * r20
		array[2]  = m20 * r00 + m21 * r10 + m22 * r20
		array[3]  = m30 * r00 + m31 * r10 + m32 * r20
		
		array[4]  = m00 * r01 + m01 * r11 + m02 * r21
		array[5]  = m10 * r01 + m11 * r11 + m12 * r21
		array[6]  = m20 * r01 + m21 * r11 + m22 * r21
		array[7]  = m30 * r01 + m31 * r11 + m32 * r21
		
		array[8]  = m00 * r02 + m01 * r12 + m02 * r22
		array[9]  = m10 * r02 + m11 * r12 + m12 * r22
		array[10] = m20 * r02 + m21 * r12 + m22 * r22
		array[11] = m30 * r02 + m31 * r12 + m32 * r22
		
		array[12] = m03
		array[13] = m13
		array[14] = m23
		array[15] = m33
	}
	
	
	/**
	Rotates the matrix around the x axis
	
	- parameter alpha: The angle
	*/
	mutating public func rotateX (deg degree: GLfloat) {
		let rad : GLfloat = deg2rad(degree)
		rotateX(rad: rad)
	}
	
	
	/**
	Rotates the matrix around the x axis
	
	- parameter alpha: The angle
	*/
	mutating public func rotateX (rad radian: GLfloat) {
		let m01 = array[4], m11 = array[5], m21 = array[6], m31 = array[7]
		let m02 = array[8], m12 = array[9], m22 = array[10], m32 = array[11]
		
		let c = cos(radian)
		let s = sin(radian)
		
		array[4] = m01 * c + m02 * s
		array[5] = m11 * c + m12 * s
		array[6] = m21 * c + m22 * s
		array[7] = m31 * c + m32 * s
		array[8] = m01 * -s + m02 * c
		array[9] = m11 * -s + m12 * c
		array[10] = m21 * -s + m22 * c
		array[11] = m31 * -s + m32 * c
	}
	
	
	/**
	Rotates the matrix around the y axis
	
	- parameter alpha: The angle
	*/
	mutating public func rotateY (deg degree: GLfloat) {
		let rad : GLfloat = deg2rad(degree)
		rotateY(rad: rad)
	}
	
	
	/**
	Rotates the matrix around the y axis
	
	- parameter alpha: The angle
	- parameter x: Component of the rotation vector
	- parameter y: Component of the rotation vector
	- parameter z: Component of the rotation vector
	*/
	mutating public func rotateY (rad radian: GLfloat) {
		
		let m00 = array[0], m10 = array[4], m20 = array[8], m30 = array[12]
		let m02 = array[2], m12 = array[6], m22 = array[10], m32 = array[14]
		
		let c = cos(radian)
		let s = sin(radian)
		
		array[0] = m00 * c + m02 * -s
		array[4] = m10 * c + m12 * -s
		array[8] = m20 * c + m22 * -s
		array[12] = m30 * c + m32 * -s
		array[2] = m00 * s + m02 * c
		array[6] = m10 * s + m12 * c
		array[10] = m20 * s + m22 * c
		array[14] = m30 * s + m32 * c
	}
	
	
	/**
	Rotates the matrix around the z axis
	
	- parameter deg: The angle in degrees
	*/
	mutating public func rotateZ (deg degree: GLfloat) {
		let rad : GLfloat = deg2rad(degree)
		rotateZ(rad: rad)
	}
	
	/**
	Rotates the matrix around the z axis
	
	- parameter rad: The angle in radians
	*/
	mutating public func rotateZ (rad radian: GLfloat) {
		let m00 = array[0], m10 = array[1], m20 = array[2], m30 = array[3]
		let m01 = array[4], m11 = array[5], m21 = array[6], m31 = array[7]
		
		let c = cos(radian)
		let s = sin(radian)
		
		array[0] = m00 * c + m01 * s
		array[1] = m10 * c + m11 * s
		array[2] = m20 * c + m21 * s
		array[3] = m30 * c + m31 * s
		array[4] = m00 * -s + m01 * c
		array[5] = m10 * -s + m11 * c
		array[6] = m20 * -s + m21 * c
		array[7] = m30 * -s + m31 * c
	}
	
	
	/**
	Translates in x direction
	
	- parameter x:
	*/
	public mutating func translateX (tx: GLfloat) {
		let x : GLfloat = array[0] * tx + array[12]
		let y : GLfloat = array[1] * tx + array[13]
		let z : GLfloat = array[2] * tx + array[14]
		let w : GLfloat = array[3] * tx + array[15]
		
		self[col: 3] = vec4(x, y, z, w)
	}
	
	
	/**
	Translates in y direction
	
	- parameter y:
	*/
	public mutating func translateY (ty: GLfloat) {
		let x : GLfloat = array[4] * ty + array[12]
		let y : GLfloat = array[5] * ty + array[13]
		let z : GLfloat = array[6] * ty + array[14]
		let w : GLfloat = array[7] * ty + array[15]
		
		self[col: 3] = vec4(x, y, z, w)
	}
	
	
	/**
	Translates in z direction
	
	- parameter z:
	*/
	public mutating func translateZ (tz: GLfloat) {
		let x : GLfloat = array[8] * tz + array[12]
		let y : GLfloat = array[9] * tz + array[13]
		let z : GLfloat = array[10] * tz + array[14]
		let w : GLfloat = array[11] * tz + array[15]
		
		self[col: 3] = vec4(x, y, z, w)
	}
	
	
	/**
	Translates the matrix along the vector passed as single components
	
	- parameter x: The x component of the translation vector
	- parameter y: The y component of the translation vector
	- parameter z: The z component of the translation vector
	*/
	mutating public func translate (x dx: GLfloat, y dy: GLfloat, z dz: GLfloat) {
		let ax : GLfloat = array[0] * dx
		let bx : GLfloat = array[4] * dy
		let cx : GLfloat = array[8] * dz + array[12]
		
		let ay : GLfloat = array[1] * dx
		let by : GLfloat = array[5] * dy
		let cy : GLfloat = array[9] * dz + array[13]
		
		let az : GLfloat = array[2] * dx
		let bz : GLfloat = array[6] * dy
		let cz : GLfloat = array[10] * dz + array[14]
		
		let aw : GLfloat = array[3] * dx
		let bw : GLfloat = array[7] * dy
		let cw : GLfloat = array[11] * dz + array[15]
		
		self[col: 3] = vec4(ax + bx + cx, ay + by + cy, az + bz + cz, aw + bw + cw)
	}
	
	
	/**
	Translates the matrix along the passed vector
	
	- parameter vec: The vector to translate along
	*/
	mutating public func translate (vec: vec3) {
		translate(x: vec.x, y: vec.y, z: vec.z)
	}
	
	
	/**
	Determines if the passed index is valid for accessing components
	of the matrix.
	
	- parameter index: The index to validate
	- returns: True when index is valid (between 0 and 3), otherwise false
	*/
	private func valid (index: Int) -> Bool {
		return index >= 0 && index < 4
	}
}


/*
|--------------------------------------------------------------------------
| Extensions
|--------------------------------------------------------------------------
*/

/** 
Array literal convertibal initalizer
*/
extension mat4 : ArrayLiteralConvertible {
	public init(arrayLiteral elements: GLfloat...) {
		self.init(elements)
	}
}


/**
Array representable initalizer
*/
extension mat4 : ArrayRepresentable {
	public init(_ array: [GLfloat]) {
		let maximum : Int = min(mat4.elementCount, array.count)
		for index in 0..<maximum {
			self.array[index] = array[index]
		}
	}
}


/**
Equatable
*/
extension mat4 : Equatable {}

public func ==(left: mat4, right: mat4) -> Bool {
	for index in 0...15 {
		if left.array[index] != right.array[index] {return false}
	}
	
	return true
}


/** 
Printable
*/
extension mat4 : CustomStringConvertible {
	public var description : String {get {return toString(self)}}
}


/*
|--------------------------------------------------------------------------
| Static Extensions
|--------------------------------------------------------------------------
*/

extension mat4 {
	
	/**
	Provides the identity matrix
	*/
	public static let identity : mat4 = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]
	
	
	/**
	Creates a rotation matrix with rotation angle alpha around the x axis
	
	- parameter alpha: The rotation angle in radians
	- returns: The rotation matrix
	*/
	public static func makeRotationX (rad radian: GLfloat) -> mat4 {
		let cosine = cos(radian)
		let sinus = sin(radian)
		
		return [
			1.0, 0.0, 0.0, 0.0,
			0.0, cosine, sinus, 0.0,
			0.0, -sinus, cosine, 0.0,
			0.0, 0.0, 0.0, 1.0
		]
	}
	
	
	/**
	Creates a rotation matrix with rotation angle alpha around the x axis
	
	- parameter alpha: The rotation angle in degrees
	- returns: The rotation matrix
	*/
	public static func makeRotationX (deg degree: GLfloat) -> mat4 {
		let radian : GLfloat = deg2rad(degree)
		return makeRotationX(rad: radian)
	}
	
	
	/**
	Creates a rotation matrix with rotation angle alpha around the y axis
	
	- parameter alpha: The rotation angle in radians
	- returns: The rotation matrix
	*/
	public static func makeRotationY (rad radian: GLfloat) -> mat4 {
		let cosine = cos(radian)
		let sinus = sin(radian)
		return [
			cosine, 0.0, -sinus, 0.0,
			0.0, 1.0, 0.0, 0.0,
			sinus, 0.0, cosine, 0.0,
			0.0, 0.0, 0.0, 1.0
		]
	}
	
	
	/**
	Creates a rotation matrix with rotation angle alpha around the y axis
	
	- parameter alpha: The rotation angle in degrees
	- returns: The rotation matrix
	*/
	public static func makeRotationY (deg degree: GLfloat) -> mat4 {
		let radian : GLfloat = deg2rad(degree)
		return makeRotationY(rad: radian)
	}
	
	
	/**
	Creates a z rotation matrix with rotation angle alpha
	
	- parameter alpha: The rotation angle
	- returns: The rotation matrix
	*/
	public static func makeRotationZ (rad radian: GLfloat) -> mat4 {
		let cosine = cos(radian)
		let sinus = sin(radian)
		return [
			cosine, sinus, 0.0, 0.0,
			-sinus, cosine, 0.0, 0.0,
			0.0, 0.0, 1.0, 0.0,
			0.0, 0.0, 0.0, 1.0
		]
	}
	
	
	/**
	Creates a rotation matrix with rotation angle alpha around the z axis
	
	- parameter alpha: The rotation angle in degrees
	- returns: The rotation matrix
	*/
	public static func makeRotationZ (deg degree: GLfloat) -> mat4 {
		let radian : GLfloat = deg2rad(degree)
		return makeRotationZ(rad: radian)
	}
	
	
	/**
	Creates a rotation matrix for an arbitrary axis with rotation angle alpha
	
	- parameter alpha: The rotation angle
	- parameter axis: The vector to rotate around
	- returns: The rotation matrix
	*/
	public static func makeRotation (alpha a: GLfloat, axis: vec3) -> mat4 {
		return mat4.makeRotation(alpha: a, x: axis.x, y: axis.y, z: axis.z)
	}
	
	
	/**
	Creates a rotation matrix for an arbitrary axis with rotation angle alpha
	
	- parameter alpha: The rotation angle
	- parameter x: The x component of the translation vector
	- parameter y: The y component of the translation vector
	- parameter z: The z component of the translation vector
	- returns: The rotation matrix
	*/
	public static func makeRotation (alpha a: GLfloat, x ax: GLfloat, y ay: GLfloat, z az: GLfloat) -> mat4 {
		
		let c = cos(a)
		let d = 1 - c
		let s = sin(a)
		
		var m : mat4 = mat4()
		m.array[0] = ax * ax * d + c
		m.array[1] = ax * ay * d + az * s
		m.array[2] = ax * az * d - ay * s
		m.array[3] = 0

		m.array[4] = ax * ay * d - az * s
		m.array[5] = ay * ay * d + c
		m.array[6] = ay * az * d + ax * s
		m.array[7] = 0

		m.array[8] = ax * az * d + ay * s
		m.array[9] = ay * az * d - ax * s
		m.array[10] = az * az * d + c
		m.array[11] = 0

		m.array[12] = 0
		m.array[13] = 0
		m.array[14] = 0
		m.array[15] = 1
		return m
	}
	
	
	/**
	Returns a matrix with translation in given direction
	
	- parameter direction: The direction for the translation
	:return: The translation matrix
	*/
	public static func makeTranslate (direction: vec3) -> mat4 {
		return makeTranslate(x: direction.x, y: direction.y, z: direction.z)
	}
	
	
	/**
	Returns a matrix with translation in given direction
	
	- parameter x: The x direction for the translation
	- parameter y: The y direction for the translation
	- parameter z: The z direction for the translation
	:return: The translation matrix
	*/
	public static func makeTranslate (x dx: GLfloat, y dy: GLfloat, z dz: GLfloat) -> mat4 {
		return [
			1.0, 0.0, 0.0, 0,
			0.0, 1.0, 0.0, 0,
			0.0, 0.0, 1.0, 0,
			dx, dy, dz, 1.0
		]
	}
	
	
	/** 
	Returns a orthographic projection matrix
	
	- parameter left: The left bound of the view volume
	- parameter right: The right bound of the view volume
	- parameter bottom: The bottom bound of the view volume
	- parameter top: The top bound of the view volume
	- parameter near: The near bound of the view volume
	- parameter far: The far bound of the view volume
	*/
	public static func makeOrtho (left l: GLfloat, right: GLfloat, bottom: GLfloat,
		top: GLfloat, near: GLfloat, far: GLfloat) -> mat4 {
			
			let x = 2 / (right - l)
			let y = 2 / (top - bottom)
			let z = -2 / (far - near)
			let a = -(right + l) / (right - l)
			let b = -(top + bottom) / (top - bottom)
			let c = -(far + near) / (far - near)
			
			return [
				x, 0.0, 0.0, 0,
				0.0, y, 0.0, 0,
				0.0, 0.0, z, 0,
				a, b, c, 1.0
			]
	}
	
	
	/**
	Creates a perspective projection matrix
	
	- parameter left: The left boundary of the viewport
	- parameter right: The right boundary of the viewport
	- parameter top: The top boundary of the viewport
	- parameter bottom: The bottom boundary of the viewport
	- parameter near: The near boundary
	- parameter far: The far boundary
	*/
	public static func makeFrustum (left l: GLfloat, right: GLfloat, bottom: GLfloat, top: GLfloat, near: GLfloat, far: GLfloat) -> mat4 {
		let x = (2 * near) / (right - l)
		let y = (2 * near) / (top - bottom)
		let a = (right + l) / (right - l)
		let b = (top + bottom) / (top - bottom)
		let c = -(far + near) / (far - near)
		let d = -(2 * far * near) / (far - near)

		return [
			x, 0, 0, 0,
			0, y, 0, 0,
			a, b, c, -1,
			0, 0, d, 0
		]
	}
	
	
	/**
	Returns a perspective projection matrix
	
	- parameter  fovy:
	- parameter  aspect:
	- parameter  near:
	- parameter  far:
 	*/
	public static func makePerspective (fovy f: GLfloat, aspect: GLfloat, near: GLfloat, far: GLfloat) -> mat4 {
		
		let angle = f / 2
		let dz = far - near
		let sinAngle = sin(angle)
		if (dz == 0 || sinAngle == 0 || aspect == 0) {
			return mat4.identity
		}
			
		let cot = cos(angle) / sinAngle
		return [
			cot / aspect, 0, 0, 0,
			0, cot, 0, 0,
			0, 0, -(far + near) / dz, -(2 * near * far) / dz,
			0, 0, -1, 0
		]
	}
}


/*
|--------------------------------------------------------------------------
| Operators
|--------------------------------------------------------------------------
*/

/// Negates the matrix, by negating each element
public prefix func -(l: mat4) -> mat4 {
	var mat : [GLfloat] = l.array
	
	mat[0] = -mat[0]
	mat[1] = -mat[1]
 	mat[2] = -mat[2]
 	mat[3] = -mat[3]
	mat[4] = -mat[4]
 	mat[5] = -mat[5]
	mat[6] = -mat[6]
	mat[7] = -mat[7]
	mat[8] = -mat[8]
	mat[9] = -mat[9]
	mat[10] = -mat[10]
	mat[11] = -mat[11]
	mat[12] = -mat[12]
	mat[13] = -mat[13]
	mat[14] = -mat[14]
	mat[15] = -mat[15]
	
	
	return [
		mat[0], mat[1], mat[2], mat[3],
		mat[4], mat[5], mat[6], mat[9],
		mat[8], mat[9], mat[10], mat[11],
		mat[12], mat[13], mat[14], mat[15]
	]
}


/// Matrix addition
public func +(l: mat4, r: mat4) -> mat4 {
	return [
		l[0, 0] + r[0, 0], l[0, 1] + r[0, 1], l[0, 2] + r[0, 2], l[0, 3] + r[0, 3],
		l[1, 0] + r[1, 0], l[1, 0] + r[1, 0], l[1, 2] + r[1, 2], l[1, 3] + r[1, 3],
		l[2, 0] + r[2, 0], l[2, 0] + r[2, 0], l[2, 2] + r[2, 2], l[2, 3] + r[2, 3],
		l[3, 0] + r[3, 0], l[3, 0] + r[3, 0], l[3, 2] + r[3, 2], l[3, 3] + r[3, 3]
	]
}


/// Matrix subtraction
public func -(l: mat4, r: mat4) -> mat4 {
	return l + -r
}


/// Matrix multiplication
public func *(l: mat4, r: mat4) -> mat4 {
	var resultMat : [GLfloat] = []
	
	let mat0 = l.array
	let mat1 = r.array
	
	let a00 = mat0[0], a10 = mat0[1], a20 = mat0[2], a30 = mat0[3]
	let a01 = mat0[4], a11 = mat0[5], a21 = mat0[6], a31 = mat0[7]
	let a02 = mat0[8], a12 = mat0[9], a22 = mat0[10], a32 = mat0[11]
	let a03 = mat0[12], a13 = mat0[13], a23 = mat0[14], a33 = mat0[15]
	
	let b00 = mat1[0], b10 = mat1[1], b20 = mat1[2], b30 = mat1[3]
	let b01 = mat1[4], b11 = mat1[5], b21 = mat1[6], b31 = mat1[7]
	let b02 = mat1[8], b12 = mat1[9], b22 = mat1[10], b32 = mat1[11]
	let b03 = mat1[12], b13 = mat1[13], b23 = mat1[14], b33 = mat1[15]
	
	resultMat.append(a00 * b00 + a01 * b10 + a02 * b20 + a03 * b30)
	resultMat.append(a10 * b00 + a11 * b10 + a12 * b20 + a13 * b30)
	resultMat.append(a20 * b00 + a21 * b10 + a22 * b20 + a23 * b30)
	resultMat.append(a30 * b00 + a31 * b10 + a32 * b20 + a33 * b30)
	
	resultMat.append(a00 * b01 + a01 * b11 + a02 * b21 + a03 * b31)
	resultMat.append(a10 * b01 + a11 * b11 + a12 * b21 + a13 * b31)
	resultMat.append(a20 * b01 + a21 * b11 + a22 * b21 + a23 * b31)
	resultMat.append(a30 * b01 + a31 * b11 + a32 * b21 + a33 * b31)
	
	resultMat.append(a00 * b02 + a01 * b12 + a02 * b22 + a03 * b32)
	resultMat.append(a10 * b02 + a11 * b12 + a12 * b22 + a13 * b32)
	resultMat.append(a20 * b02 + a21 * b12 + a22 * b22 + a23 * b32)
	resultMat.append(a30 * b02 + a31 * b12 + a32 * b22 + a33 * b32)
	
	resultMat.append(a00 * b03 + a01 * b13 + a02 * b23 + a03 * b33)
	resultMat.append(a10 * b03 + a11 * b13 + a12 * b23 + a13 * b33)
	resultMat.append(a20 * b03 + a21 * b13 + a22 * b23 + a23 * b33)
	resultMat.append(a30 * b03 + a31 * b13 + a32 * b23 + a33 * b33)
	return mat4(resultMat)
}


//,/ Left side multiplication of a matrix and a vector. The vector is
/// considered as a column vector
public func *(l: mat4, r: vec4) -> vec4 {
	return [dot(l[row: 0], r: r), dot(l[row: 1], r: r), dot(l[row: 2], r: r), dot(l[row: 3], r: r)]
}


/// Right side multiplication of a matrix and a vector. The vector is
/// considered as a row vector
public func *(l: vec4, r: mat4) -> vec4 {
	return [dot(l, r: r[col: 0]), dot(l, r: r[col: 1]), dot(l, r: r[col: 2]), dot(l, r: r[col: 3])]
}


/// Left side Scalar multiplication with a matrix
public func *(l: GLfloat, r: mat4) -> mat4 {
	return [
		l * r[0, 0], l * r[0, 1], l * r[0, 2], l * r[0, 3],
		l * r[1, 0], l * r[1, 1], l * r[1, 2], l * r[1, 3],
		l * r[2, 0], l * r[2, 1], l * r[2, 2], l * r[2, 3],
		l * r[3, 0], l * r[3, 1], l * r[3, 2], l * r[3, 3],
	]
}


/// Left side Scalar multiplication with a matrix
public func *(l: mat4, r: GLfloat) -> mat4 {
	return r * l
}