//
//  mat4.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct mat4 : QuadraticMatrixType {
	
	public static let rows : Int = 4
	
	public static var cols : Int {get {return rows}}
	
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/** The size of a vector */
	public static var elementCount : Int {get {return rows * cols}}
	
	/** 
	Provides a list of matrix components in major-row
	represenstation 
	*/
	private var _mat : [GLfloat] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	
	/**
	Provides the determinant of the matrix
	*/
	public var determinant : GLfloat {
		let m : mat4 = self
		
		let row : vec4 = m[row: 0]
		
		let a : GLfloat = row.x * submatrix(row: 0, col: 0).determinant
		let b : GLfloat = row.y * submatrix(row: 0, col: 1).determinant
		let c : GLfloat = row.z * submatrix(row: 0, col: 2).determinant
		let d : GLfloat = row.w * submatrix(row: 0, col: 3).determinant
		
		return a - b + c - d
	}
	
	/**
	Provides the transposed matrix of this matrix
	*/
	public var transposed : mat4 {
		let m : mat4 = self
		return [
			m[0, 0], m[1, 0], m[2, 0], m[3, 0],
			m[0, 1], m[1, 1], m[2, 1], m[3, 1],
			m[0, 2], m[1, 2], m[2, 2], m[3, 2],
			m[0, 3], m[1, 3], m[2, 3], m[3, 3]
		]
	}
	
	
	public var array : [GLfloat] {
		get {return _mat}
	}
	
	
	/**
	Array access for row vectors
	*/
	subscript(row index: Int) -> vec4 {
		get {
			assert(valid(index), "Invalid mat4 index access.")
			return vec4(_mat[index], _mat[index + 4], _mat[index + 8], _mat[index + 12])
		}
		
		set {
			assert(valid(index), "Invalid mat4 index access.")
			_mat[index] = newValue.x
			_mat[index + 4] = newValue.y
			_mat[index + 8] = newValue.z
			_mat[index + 12] = newValue.w
		}
	}
	
	/**
	Array access for column vectors
	*/
	subscript(col index: Int) -> vec4 {
		get {
		assert(valid(index), "Invalid mat4 index access.")
		return vec4(_mat[index * 4], _mat[index * 4 + 1], _mat[index * 4 + 2], _mat[index * 4 + 3])
		}
		
		set {
		assert(valid(index), "Invalid mat4 index access.")
		_mat[index * 4] = newValue.x
		_mat[index * 4 + 1] = newValue.y
		_mat[index * 4 + 2] = newValue.z
		_mat[index * 4 + 3] = newValue.w
		}
	}
	
	/**
	Array access for single components
	*/
	subscript(row: Int, col: Int) -> GLfloat {
		get {
			assert(valid(row) && valid(col), "Invalid mat4 index access.")
			return _mat[col * 4 + row]
		}
		
		set {
			assert(valid(row) && valid(col), "Invalid mat4 index access.")
			_mat[col * 4 + row] = newValue
		}
	}
	
	
	/**
	Default initializer. Fills the matrix with zeros
	*/
	public init () {

	}
	
	
	public func submatrix(row rowIndex: Int, col colIndex: Int) -> mat3 {
		assert(valid(rowIndex) && valid(colIndex), "Bad index access for mat4")
		
		var m : [GLfloat] = _mat
		for var r : Int = 3; r >= 0; r-- {
			for var c : Int = 3; c >= 0; c-- {
				if r == rowIndex || c == colIndex {
					m.removeAtIndex(c * 4 + r)
				}
			}
		}
		
		return [m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]]
	}
	
	
	/**
	Rotates the matrix around an arbitrary axis, given by vec
	
	:param: alpha The angle to rotate about
	:param: vec The axis to rotate around
	*/
	mutating public func rotate (alpha a: GLfloat, vec: vec3) {
		rotate(alpha: a, x: vec.x, y: vec.y, z: vec.z)
	}
	
	
	/**
	Rotates the matrix around an arbitrary axis, given by the vector components
	
	:param: alpha The angle to rotate about
	:param: vec The axis to rotate around
	*/
	mutating public func rotate (alpha a: GLfloat, x dx: GLfloat, y dy: GLfloat, z dz: GLfloat) {
		var m00 = _mat[0], m10 = _mat[1], m20 = _mat[2], m30 = _mat[3]
		var m01 = _mat[4], m11 = _mat[5], m21 = _mat[6], m31 = _mat[7]
		var m02 = _mat[8], m12 = _mat[9], m22 = _mat[10], m32 = _mat[11]
		var m03 = _mat[12], m13 = _mat[13], m23 = _mat[14], m33 = _mat[15]
			
		var cosAngle = cos(a)
		var sinAngle = sin(a)
		var diffCosAngle = 1 - cosAngle
		var r00 = dx * dx * diffCosAngle + cosAngle
		var r10 = dx * dy * diffCosAngle + dz * sinAngle
		var r20 = dx * dz * diffCosAngle - dy * sinAngle
			
		var r01 = dx * dy * diffCosAngle - dz * sinAngle
		var r11 = dy * dy * diffCosAngle + cosAngle
		var r21 = dy * dz * diffCosAngle + dx * sinAngle
			
		var r02 = dx * dz * diffCosAngle + dy * sinAngle
		var r12 = dy * dz * diffCosAngle - dx * sinAngle
		var r22 = dz * dz * diffCosAngle + cosAngle
			

		_mat[0]  = m00 * r00 + m01 * r10 + m02 * r20
		_mat[1]  = m10 * r00 + m11 * r10 + m12 * r20
		_mat[2]  = m20 * r00 + m21 * r10 + m22 * r20
		_mat[3]  = m30 * r00 + m31 * r10 + m32 * r20
		
		_mat[4]  = m00 * r01 + m01 * r11 + m02 * r21
		_mat[5]  = m10 * r01 + m11 * r11 + m12 * r21
		_mat[6]  = m20 * r01 + m21 * r11 + m22 * r21
		_mat[7]  = m30 * r01 + m31 * r11 + m32 * r21

		_mat[8]  = m00 * r02 + m01 * r12 + m02 * r22
		_mat[9]  = m10 * r02 + m11 * r12 + m12 * r22
		_mat[10] = m20 * r02 + m21 * r12 + m22 * r22
		_mat[11] = m30 * r02 + m31 * r12 + m32 * r22

		_mat[12] = m03
		_mat[13] = m13
		_mat[14] = m23
		_mat[15] = m33
	}
	
	
	/**
	Rotates the matrix around the x axis
	
	:param: alpha The angle
	*/
	mutating public func rotateX (alpha a: GLfloat) {
		var m01 = _mat[4], m11 = _mat[5], m21 = _mat[6], m31 = _mat[7]
		var m02 = _mat[8], m12 = _mat[9], m22 = _mat[10], m32 = _mat[11]
			
		var c = cos(a)
		var s = sin(a)
			
		_mat[4] = m01 * c + m02 * s
		_mat[5] = m11 * c + m12 * s
		_mat[6] = m21 * c + m22 * s
		_mat[7] = m31 * c + m32 * s
		_mat[8] = m01 * -s + m02 * c
		_mat[9] = m11 * -s + m12 * c
		_mat[10] = m21 * -s + m22 * c
		_mat[11] = m31 * -s + m32 * c
	}
	
	
	/**
	Rotates the matrix around the y axis
	
	:param: alpha The angle
	:param: x Component of the rotation vector
	:param: y Component of the rotation vector
	:param: z Component of the rotation vector
	*/
	mutating public func rotateY (alpha a: GLfloat) {
		let m00 = _mat[0], m10 = _mat[4], m20 = _mat[8], m30 = _mat[12]
		let m02 = _mat[2], m12 = _mat[6], m22 = _mat[10], m32 = _mat[14]
		
		let c = cos(a)
		let s = sin(a)
		
		_mat[0] = m00 * c + m02 * -s
		_mat[4] = m10 * c + m12 * -s
		_mat[8] = m20 * c + m22 * -s
		_mat[12] = m30 * c + m32 * -s
		_mat[2] = m00 * s + m02 * c
		_mat[6] = m10 * s + m12 * c
		_mat[10] = m20 * s + m22 * c
		_mat[14] = m30 * s + m32 * c
	}
	
	
	/**
	Rotates the matrix around the z axis
	
	:param: alpha The angle
	*/
	mutating public func rotateZ (alpha a: GLfloat) {
		let m00 = _mat[0], m10 = _mat[4], m20 = _mat[8], m30 = _mat[12]
		let m01 = _mat[1], m11 = _mat[5], m21 = _mat[7], m31 = _mat[13]
		
		let c = cos(a)
		let s = sin(a)
		
		_mat[0] = m00 * c + m01 * s
		_mat[4] = m10 * c + m11 * s
		_mat[8] = m20 * c + m21 * s
		_mat[12] = m30 * c + m31 * s
		_mat[1] = m00 * -s + m01 * c
		_mat[5] = m10 * -s + m11 * c
		_mat[7] = m20 * -s + m21 * c
		_mat[13] = m30 * -s + m31 * c
	}
	
	
	/**
	Translates the matrix along the passed vector
	
	:param: vec The vector to translate along
	*/
	mutating public func translate (vec: vec3) {
		translate(x: vec.x, y: vec.y, z: vec.z)
	}
	
	
	/**
	Translates the matrix along the vector passed as single components
	
	:param: x The x component of the translation vector
	:param: y The y component of the translation vector
	:param: z The z component of the translation vector
	*/
	mutating public func translate (x dx: GLfloat, y dy: GLfloat, z dz: GLfloat) {
		let ax : GLfloat = _mat[0] * dx
		let bx : GLfloat = _mat[4] * dy
		let cx : GLfloat = _mat[8] * dz + _mat[12]
		
		let ay : GLfloat = _mat[1] * dx
		let by : GLfloat = _mat[5] * dy
		let cy : GLfloat = _mat[9] * dz + _mat[13]
		
		let az : GLfloat = _mat[2] * dx
		let bz : GLfloat = _mat[6] * dy
		let cz : GLfloat = _mat[10] * dz + _mat[14]
		
		let aw : GLfloat = _mat[3] * dx
		let bw : GLfloat = _mat[7] * dy
		let cw : GLfloat = _mat[11] * dz + _mat[15]
		
		var m = self
		m[col: 3] = vec4(ax + bx + cx, ay + by + cy, az + bz + cz, aw + bw + cw)
	}
	
	
	/**
	Determines if the passed index is valid for accessing components
	of the matrix.
	
	:param: index The index to validate
	:returns: True when index is valid (between 0 and 3), otherwise false
	*/
	private func valid (index: Int) -> Bool {
		return index >= 0 && index < 4
	}
}


// Extensions
// **********

extension mat4 : ArrayLiteralConvertible {
	public init(arrayLiteral elements: GLfloat...) {
		let maximum : Int = min(mat4.elementCount, elements.count)
		_mat = [GLfloat](count: maximum, repeatedValue: 0.0)
		for index in 0..<maximum {
			_mat[index] = elements[index]
		}
	}
}

extension mat4 : ArrayRepresentable {
	public init(_ array: [GLfloat]) {
		for index in 0..<mat4.elementCount {
			_mat[index] = array.count > index ? array[index] : 0
		}
	}
}


extension mat4 : Equatable {}

public func ==(left: mat4, right: mat4) -> Bool {
	for index in 0...15 {
		if left._mat[index] != right._mat[index] {
			return false
		}
	}
	
	return true
}


extension mat4 : Printable {
	public var description : String {
		get {
			var maxlen : Int = 0
			for index in 0...(_mat.count - 1) {
				maxlen = max(maxlen, countElements(_mat[index].description))
			}
			
			maxlen++
			
			var output : String = ""
			let m : mat4 = self
			
			for r in 0...3 {
				output += "|"
				for c in 0...3 {
					var fillLen : Int = maxlen - countElements(m[r, c].description)
					var white : String = " " * fillLen
					output += white + m[r, c].description
				}
				output += "|\n"
			}
			return output
		}
	}
}


// Static
// ******

extension mat4 {
	
	/**
	Provides the identity matrix
	*/
	public static let identity : mat4 = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]
	
	
	/** 
	Creates a rotation matrix with rotation angle alpha
	
	:param: alpha The rotation angle
	:returns: The rotation matrix
	*/
	public static func makeRotationX (alpha: GLfloat) -> mat4 {
		let cosine = cos(alpha)
		let sinus = sin(alpha)
		
		return [
			1.0, 0.0, 0.0, 0.0,
			0.0, cosine, sinus, 0.0,
			0.0, -sinus, cosine, 0.0,
			0.0, 0.0, 0.0, 1.0
		]
	}
	
	
	/**
	Creates a y rotation matrix with rotation angle alpha
	
	
	:param: alpha The rotation angle
	:returns: The rotation matrix
	*/
	public static func makeRotationY (alpha: GLfloat) -> mat4 {
		let cosine = cos(alpha)
		let sinus = sin(alpha)
		return [
			cosine, 0.0, -sinus, 0.0,
			0.0, 1.0, 0.0, 0.0,
			sinus, 0.0, cosine, 0.0,
			0.0, 0.0, 0.0, 1.0
		]
	}
	
	
	/**
	Creates a z rotation matrix with rotation angle alpha
	
	:param: alpha The rotation angle
	:returns: The rotation matrix
	*/
	public static func makeRotationZ (alpha: GLfloat) -> mat4 {
		let cosine = cos(alpha)
		let sinus = sin(alpha)
		return [
			cosine, sinus, 0.0, 0.0,
			-sinus, cosine, 0.0, 0.0,
			0.0, 0.0, 1.0, 0.0,
			0.0, 0.0, 0.0, 1.0
		]
	}
	
	
	/**
	Creates a rotation matrix for an arbitrary axis with rotation angle alpha
	
	:param: alpha The rotation angle
	:param: axis The vector to rotate around
	:returns: The rotation matrix
	*/
	public static func makeRotation (alpha a: GLfloat, axis: vec3) -> mat4 {
		return mat4.makeRotation(alpha: a, x: axis.x, y: axis.y, z: axis.z)
	}
	
	
	/**
	Creates a rotation matrix for an arbitrary axis with rotation angle alpha
	
	:param: alpha The rotation angle
	:param: x The x component of the translation vector
	:param: y The y component of the translation vector
	:param: z The z component of the translation vector
	:returns: The rotation matrix
	*/
	public static func makeRotation (alpha a: GLfloat, x ax: GLfloat, y ay: GLfloat, z az: GLfloat) -> mat4 {
		
		let c = cos(a)
		let d = 1 - c
		let s = sin(a)
		
		var m : mat4 = mat4()
		m._mat[0] = ax * ax * d + c
		m._mat[1] = ax * ay * d + az * s
		m._mat[2] = ax * az * d - ay * s
		m._mat[3] = 0

		m._mat[4] = ax * ay * d - az * s
		m._mat[5] = ay * ay * d + c
		m._mat[6] = ay * az * d + ax * s
		m._mat[7] = 0

		m._mat[8] = ax * az * d + ay * s
		m._mat[9] = ay * az * d - ax * s
		m._mat[10] = az * az * d + c
		m._mat[11] = 0

		m._mat[12] = 0
		m._mat[13] = 0
		m._mat[14] = 0
		m._mat[15] = 1
		return m
	}
	
	
	public static func makeTranslate (direction: vec3) -> mat4 {
		return makeTranslate(x: direction.x, y: direction.y, z: direction.z)
	}
	
	
	public static func makeTranslate (x dx: GLfloat, y dy: GLfloat, z dz: GLfloat) -> mat4 {
		return [
			1.0, 0.0, 0.0, 0,
			0.0, 1.0, 0.0, 0,
			0.0, 0.0, 1.0, 0,
			dx, dy, dz, 1.0
		]
	}
	
	
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
	
	:param: left The left boundary of the viewport
	:param: right The right boundary of the viewport
	:param: top The top boundary of the viewport
	:param: bottom The bottom boundary of the viewport
	:param: near The near boundary
	:param: far The far boundary
	*/
	public static func makeFrustum (left l: GLfloat, right: GLfloat, bottom: GLfloat, top: GLfloat, near: GLfloat, far: GLfloat) -> mat4 {
		var x = (2 * near) / (right - l)
		var y = (2 * near) / (top - bottom)
		var a = (right + l) / (right - l)
		var b = (top + bottom) / (top - bottom)
		var c = -(far + near) / (far - near)
		var d = -(2 * far * near) / (far - near)

		return [
			x, 0, 0, 0,
			0, y, 0, 0,
			a, b, c, -1,
			0, 0, d, 0
		]
	}
	
	
	public static func makePerspective (fovy f: GLfloat, aspect: GLfloat, near: GLfloat, far: GLfloat) -> mat4 {
		
		var angle = f / 2
		var dz = far - near
		var sinAngle = sin(angle)
		if (dz == 0 || sinAngle == 0 || aspect == 0) {
			return mat4.identity
		}
			
		var cot = cos(angle) / sinAngle
		return [
			cot / aspect, 0, 0, 0,
			0, cot, 0, 0,
			0, 0, -(far + near) / dz, -(2 * near * far) / dz,
			0, 0, -1, 0
		]
	}
}



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


public func +(l: mat4, r: mat4) -> mat4 {
	return [
		l[0, 0] + r[0, 0], l[0, 1] + r[0, 1], l[0, 2] + r[0, 2], l[0, 3] + r[0, 3],
		l[1, 0] + r[1, 0], l[1, 0] + r[1, 0], l[1, 2] + r[1, 2], l[1, 3] + r[1, 3],
		l[2, 0] + r[2, 0], l[2, 0] + r[2, 0], l[2, 2] + r[2, 2], l[2, 3] + r[2, 3],
		l[3, 0] + r[3, 0], l[3, 0] + r[3, 0], l[3, 2] + r[3, 2], l[3, 3] + r[3, 3]
	]
}


public func -(l: mat4, r: mat4) -> mat4 {
	return l + -r
}


public func *(l: mat4, r: mat4) -> mat4 {
	return [
		l[row: 0] * r[col: 0],
		l[row: 0] * r[col: 1],
		l[row: 0] * r[col: 2],
		l[row: 0] * r[col: 3],
		
		l[row: 1] * r[col: 0],
		l[row: 1] * r[col: 1],
		l[row: 1] * r[col: 2],
		l[row: 1] * r[col: 3],
		
		l[row: 2] * r[col: 0],
		l[row: 2] * r[col: 1],
		l[row: 2] * r[col: 2],
		l[row: 2] * r[col: 3],
		
		l[row: 3] * r[col: 0],
		l[row: 3] * r[col: 1],
		l[row: 3] * r[col: 2],
		l[row: 3] * r[col: 3],
	]
}


public func *(l: mat4, r: vec4) -> vec4 {
	return [l[row: 0] * r, l[row: 1] * r, l[row: 2] * r, l[row: 3] * r]
}


public func *(l: vec4, r: mat4) -> vec4 {
	return [l * r[col: 0], l * r[col: 1], l * r[col: 2], l * r[col: 3]]
}


public func *(l: GLfloat, r: mat4) -> mat4 {
	return [
		l * r[0, 0], l * r[0, 1], l * r[0, 2], l * r[0, 3],
		l * r[1, 0], l * r[1, 1], l * r[1, 2], l * r[1, 3],
		l * r[2, 0], l * r[2, 1], l * r[2, 2], l * r[2, 3],
		l * r[3, 0], l * r[3, 1], l * r[3, 2], l * r[3, 3],
	]
}


public func *(l: mat4, r: GLfloat) -> mat4 {
	return r * l
}