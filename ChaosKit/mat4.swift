//
//  mat4.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct mat4 {
	
	/** 
	Provides a list of matrix components in major-row
	represenstation 
	*/
	private var mat : [CGFloat] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	
	/**
	Provides the determinant of the matrix
	*/
	public var determinant : CGFloat {
		let m : mat4 = self
		
		let row : vec4 = m[row: 0]
		
		let a : CGFloat = row.x * submatrix(row: 0, col: 0).determinant
		let b : CGFloat = row.y * submatrix(row: 0, col: 1).determinant
		let c : CGFloat = row.z * submatrix(row: 0, col: 2).determinant
		let d : CGFloat = row.w * submatrix(row: 0, col: 3).determinant
		
		return a - b + c - d
	}
	
	/**
	Provides the transposed matrix of this matrix
	*/
	public var transpose : mat4 {
		let m : mat4 = self
		return [
			m[0, 0], m[1, 0], m[2, 0], m[3, 0],
			m[0, 1], m[1, 1], m[2, 1], m[3, 1],
			m[0, 2], m[1, 2], m[2, 2], m[3, 2],
			m[0, 3], m[1, 3], m[2, 3], m[3, 3]
		]
	}
	
	
	/**
	Array access for row vectors
	*/
	subscript(row index: Int) -> vec4 {
		get {
			assert(valid(index), "Invalid mat4 index access.")
			return vec4(x: mat[index * 4], y: mat[index * 4 + 1], z: mat[index * 4 + 2], w: mat[index * 4 + 3])
		}
		
		set {
			assert(valid(index), "Invalid mat4 index access.")
			mat[index * 4] = newValue.x
			mat[index * 4 + 1] = newValue.y
			mat[index * 4 + 2] = newValue.z
			mat[index * 4 + 3] = newValue.w
		}
	}
	
	/**
	Array access for column vectors
	*/
	subscript(col index: Int) -> vec4 {
		get {
			assert(valid(index), "Invalid mat4 index access.")
			return vec4(x: mat[index], y: mat[index + 4], z: mat[index + 8], w: mat[index + 12])
		}
		
		set {
			assert(valid(index), "Invalid mat4 index access.")
			mat[index] = newValue.x
			mat[index + 4] = newValue.y
			mat[index + 8] = newValue.z
			mat[index + 12] = newValue.w
		}
	}
	
	/**
	Array access for single components
	*/
	subscript(row: Int, col: Int) -> CGFloat {
		get {
			assert(valid(row) && valid(col), "Invalid mat4 index access.")
			return mat[row * 4 + col]
		}
		
		set {
			assert(valid(row) && valid(col), "Invalid mat4 index access.")
			mat[row * 4 + col] = newValue
		}
	}
	
	
	/**
	Default initializer. Fills the matrix with zeros
	*/
	public init () {

	}
	
	
	public func submatrix(row rowIndex: Int, col colIndex: Int) -> mat3 {
		assert(valid(rowIndex) && valid(colIndex), "Bad index access for mat4")
		
		var m : [CGFloat] = mat
		for var r : Int = 3; r >= 0; r-- {
			for var c : Int = 3; c >= 0; c-- {
				if r == rowIndex || c == colIndex {
					m.removeAtIndex(r * 4 + c)
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
	mutating public func rotate (alpha a: CGFloat, vec: vec3) {
		rotate(alpha: a, x: vec.x, y: vec.y, z: vec.z)
	}
	
	
	/**
	Rotates the matrix around an arbitrary axis, given by the vector components
	
	:param: alpha The angle to rotate about
	:param: vec The axis to rotate around
	*/
	mutating public func rotate (alpha a: CGFloat, x dx: CGFloat, y dy: CGFloat, z dz: CGFloat) {
		let m = self
		
		let cosAngle = cos(a)
		let sinAngle = sin(a)
		
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
		
		let m00 = m[0, 0] * r00 + m[0, 1] * r10 + m[0, 2] * r20
		let m01 = m[0, 0] * r01 + m[0, 1] * r11 + m[0, 2] * r21
		let m02 = m[0, 0] * r02 + m[0, 1] * r12 + m[0, 2] * r22
		let m03 = m[0, 3]
		
		let m10 = m[1, 0] * r00 + m[1, 1] * r10 + m[1, 2] * r20
		let m11 = m[1, 0] * r01 + m[1, 1] * r11 + m[1, 2] * r21
		let m12 = m[1, 0] * r02 + m[1, 1] * r12 + m[1, 2] * r22
		let m13 = m[1, 3]
		
		let m20 = m[2, 0] * r00 + m[2, 1] * r10 + m[2, 2] * r20
		let m21 = m[2, 0] * r01 + m[2, 1] * r11 + m[2, 2] * r21
		let m22 = m[2, 0] * r02 + m[2, 1] * r12 + m[2, 2] * r22
		let m23 = m[2, 3]
		
		let m30 = m[3, 0] * r00 + m[3, 1] * r10 + m[3, 2] * r20
		let m31 = m[3, 0] * r01 + m[3, 1] * r11 + m[3, 2] * r21
		let m32 = m[3, 0] * r02 + m[3, 1] * r12 + m[3, 2] * r22
		let m33 = m[3, 3]
		
		mat = [
			m00, m01, m02, m03,
			m10, m11, m12, m13,
			m20, m21, m22, m23,
			m30, m31, m32, m33,
		]
	}
	
	
	/**
	Rotates the matrix around the x axis
	
	:param: alpha The angle
	*/
	mutating public func rotateX (alpha a: CGFloat) {
		let m01 : CGFloat = mat[1], m11 : CGFloat = mat[5]
		let m21 : CGFloat = mat[9], m31 : CGFloat = mat[13]
		
		let m02 : CGFloat = mat[2], m12 : CGFloat = mat[6]
		let m22 : CGFloat = mat[10], m32 : CGFloat = mat[14]
		
		let c : CGFloat = cos(a)
		let s : CGFloat = sin(a)
		
		mat[1] = m01 * c + m02 * s
		mat[5] = m11 * c + m12 * s
		mat[9] = m21 * c + m22 * s
		mat[13] = m31 * c + m32 * s
		mat[2] = m01 * -s + m02 * c
		mat[6] = m11 * -s + m12 * c
		mat[10] = m21 * -s + m22 * c
		mat[13] = m31 * -s + m32 * c
	}
	
	
	/**
	Rotates the matrix around the y axis
	
	:param: alpha The angle
	:param: x Component of the rotation vector
	:param: y Component of the rotation vector
	:param: z Component of the rotation vector
	*/
	mutating public func rotateY (alpha a: CGFloat) {
		let m00 = mat[0], m10 = mat[4], m20 = mat[8], m30 = mat[12]
		let m02 = mat[2], m12 = mat[6], m22 = mat[10], m32 = mat[14]
		
		let c = cos(a)
		let s = sin(a)
		
		mat[0] = m00 * c + m02 * -s
		mat[4] = m10 * c + m12 * -s
		mat[8] = m20 * c + m22 * -s
		mat[12] = m30 * c + m32 * -s
		mat[2] = m00 * s + m02 * c
		mat[6] = m10 * s + m12 * c
		mat[10] = m20 * s + m22 * c
		mat[14] = m30 * s + m32 * c
	}
	
	
	/**
	Rotates the matrix around the z axis
	
	:param: alpha The angle
	*/
	mutating public func rotateZ (alpha a: CGFloat) {
		let m00 = mat[0], m10 = mat[4], m20 = mat[8], m30 = mat[12];
		let m01 = mat[1], m11 = mat[5], m21 = mat[7], m31 = mat[13];
		
		let c = cos(a);
		let s = sin(a);
		
		mat[0] = m00 * c + m01 * s;
		mat[4] = m10 * c + m11 * s;
		mat[8] = m20 * c + m21 * s;
		mat[12] = m30 * c + m31 * s;
		mat[1] = m00 * -s + m01 * c;
		mat[5] = m10 * -s + m11 * c;
		mat[7] = m20 * -s + m21 * c;
		mat[13] = m30 * -s + m31 * c;
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
	mutating public func translate (x dx: CGFloat, y dy: CGFloat, z dz: CGFloat) {
		mat[3] = mat[3] + dx
		mat[7] = mat[7] + dy
		mat[11] = mat[11] + dz
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
	public init(arrayLiteral elements: CGFloat...) {
		mat = [CGFloat]()
		for index in 0...15 {
			mat.append(elements.count > index ? elements[index] : 0)
		}
	}
}


extension mat4 : Equatable {}

public func ==(left: mat4, right: mat4) -> Bool {
	for index in 0...15 {
		if left.mat[index] != right.mat[index] {
			return false
		}
	}
	
	return true
}


extension mat4 : Printable {
	public var description : String {
		get {
			var maxlen : Int = 0
			for index in 0...(mat.count - 1) {
				maxlen = max(maxlen, countElements(mat[index].description))
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
	public static var identity : mat4 {
		return [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]
	}
	
	
	/** 
	Creates a rotation matrix with rotation angle alpha
	
	:param: alpha The rotation angle
	:returns: The rotation matrix
	*/
	public static func makeRotationX (alpha: CGFloat) -> mat4 {
		let cosine = cos(alpha)
		let sinus = sin(alpha)
		
		return [
			1.0, 0.0, 0.0, 0.0,
			0.0, cosine, -sinus, 0.0,
			0.0, sinus, cosine, 0.0,
			0.0, 0.0, 0.0, 1.0
		]
	}
	
	
	/**
	Creates a y rotation matrix with rotation angle alpha
	
	
	:param: alpha The rotation angle
	:returns: The rotation matrix
	*/
	public static func makeRotationY (alpha: CGFloat) -> mat4 {
		let cosine = cos(alpha)
		let sinus = sin(alpha)
		return [
			cosine, 0.0, sinus, 0.0,
			0.0, 1.0, 0.0, 0.0,
			-sinus, 0.0, cosine, 0.0,
			0.0, 0.0, 0.0, 1.0
		]
	}
	
	
	/**
	Creates a z rotation matrix with rotation angle alpha
	
	:param: alpha The rotation angle
	:returns: The rotation matrix
	*/
	public static func makeRotationZ (alpha: CGFloat) -> mat4 {
		let cosine = cos(alpha)
		let sinus = sin(alpha)
		return [
			cosine, -sinus, 0.0, 0.0,
			sinus, cosine, 0.0, 0.0,
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
	public static func makeRotation (alpha a: CGFloat, axis: vec3) -> mat4 {
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
	public static func makeRotation (alpha a: CGFloat, x ax: CGFloat, y ay: CGFloat, z az: CGFloat) -> mat4 {
		
		let c = cos(a)
		let d = 1 - c
		let s = sin(a)
		
		let m00 : CGFloat = ax * ax * d + c
		let m01 : CGFloat = ax * ay * d - az * s
		let m02 : CGFloat = ax * az * d + ay * s
		
		let m10 : CGFloat = ax * ay * d + az * s
		let m12 : CGFloat = ay * ay * d + c
		let m13 : CGFloat = ay * az * d - ax * s
		
		let m20 : CGFloat = ax * az * d - ay * s
		let m21 : CGFloat = ay * az * d + ax * s
		let m23 : CGFloat = az * az * d + c
		
		return [
			m00, m01, m02, 0,
			m10, m12, m13, 0,
			m20, m21, m23, 0,
			0, 0, 0, 1
		]
	}
	
	
	public static func makeTranslate (direction: vec3) -> mat4 {
		return makeTranslate(x: direction.x, y: direction.y, z: direction.z)
	}
	
	
	public static func makeTranslate (x dx: CGFloat, y dy: CGFloat, z dz: CGFloat) -> mat4 {
		return [
			1.0, 0.0, 0.0, dx,
			0.0, 1.0, 0.0, dy,
			0.0, 0.0, 1.0, dz,
			0.0, 0.0, 0.0, 1.0
		]
	}
	
	
	public static func makeOrtho (left l: CGFloat, right: CGFloat, bottom: CGFloat,
		top: CGFloat, near: CGFloat, far: CGFloat) -> mat4 {
			
			let x = 2 / (right - l)
			let y = 2 / (top - bottom)
			let z = -2 / (far - near)
			let a = -(right + l) / (right - l)
			let b = -(top + bottom) / (top - bottom)
			let c = -(far + near) / (far - near)
			
			return [
				x, 0.0, 0.0, a,
				0.0, y, 0.0, b,
				0.0, 0.0, z, c,
				0.0, 0.0, 0.0, 1.0
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
	public static func makePerspective (left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat, near: CGFloat, far: CGFloat) -> mat4 {
		
		let n = 2 * near
		let rl = right - left
		let fn = far - near
		
		let m00 = n / rl
		let m02 = -(right+left) / rl
		let m11 = n / (top - bottom)
		let m12 = -(top + bottom) / (top - bottom)
		let m22 = (far + near) / fn
		let m23 = -(far * n) / fn
		
		return [
			m00, 0, m02, 0,
			0, m11, m12, 0,
			0, 0, m22, m23,
			0, 0, 1, 0
		]
	}
	
	
	public static func makePerspective (fovy f: CGFloat, aspect: CGFloat, near: CGFloat, far: CGFloat) -> mat4 {
		
		var angle = f / 2
		var dz = far - near
		var sinAngle = sin(angle)
		
		if (dz == 0 || sinAngle == 0 || aspect == 0) {
			return identity
		}
		
		var cot = cos(angle) / sinAngle
		
		var m : mat4 = mat4()
		m[0, 0] = cot / aspect
		m[1, 1] = cot
		m[2, 2] = -(far + near) / dz
		m[2, 3] = -(2 * near * far) / dz
		m[3, 2] = -1
		return m
	}
}


public func +(l: mat4, r: mat4) -> mat4 {
	return [
		l[0, 0] + r[0, 0], l[0, 1] + r[0, 1], l[0, 2] + r[0, 2], l[0, 3] + r[0, 3],
		l[1, 0] + r[1, 0], l[1, 0] + r[1, 0], l[1, 2] + r[1, 2], l[1, 3] + r[1, 3],
		l[2, 0] + r[2, 0], l[2, 0] + r[2, 0], l[2, 2] + r[2, 2], l[2, 3] + r[2, 3],
		l[3, 0] + r[3, 0], l[3, 0] + r[3, 0], l[3, 2] + r[3, 2], l[3, 3] + r[3, 3]
	]
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


public func *(l: CGFloat, r: mat4) -> mat4 {
	return [
		l * r[0, 0], l * r[0, 1], l * r[0, 2], l * r[0, 3],
		l * r[1, 0], l * r[1, 1], l * r[1, 2], l * r[1, 3],
		l * r[2, 0], l * r[2, 1], l * r[2, 2], l * r[2, 3],
		l * r[3, 0], l * r[3, 1], l * r[3, 2], l * r[3, 3],
	]
}


public func *(l: mat4, r: CGFloat) -> mat4 {
	return r * l
}