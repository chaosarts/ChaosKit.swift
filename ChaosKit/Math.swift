//
//  Math.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 02.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/*
|--------------------------------------------------------------------------
| Operators
|--------------------------------------------------------------------------
*/

infix operator • {}

/*
|--------------------------------------------------------------------------
| Functions
|--------------------------------------------------------------------------
*/

/**
Converts polar to cartesian coordinates

- parameter radius: The radius of the sphere
- parameter theta: The angel between the vector and the y-axis
- parameter phi: The angel between the vector and the x-axis
*/
public func polar2cartesian (radius: GLfloat, theta: GLfloat, phi: GLfloat) -> vec3 {
	return vec3(radius * sin(theta) * sin(phi), radius * cos(theta), radius * sin(theta) * cos(phi))
}


/** 
Converts cartesian coordinates into polar coordinates around the zero vector
*/
public func cartesian2polar (position: vec3) -> (radius: GLfloat, theta: GLfloat, phi: GLfloat) {
	let radius : GLfloat = position.magnitude
	let theta : GLfloat = GLfloat(M_PI / 2) - atan(position.z / sqrt(position.x * position.x + position.y * position.y))
	let phi : GLfloat = atan2(position.x, position.y)
	
	return (radius, theta, phi)
}


public func restrict<C: Comparable> (value: C, minValue: C, maxValue: C) -> C {
	return max(minValue, min(maxValue, value))
}


public func deg2rad (value: Float) -> Float {
	return Float(M_PI / 180.0) * value
}


public func deg2rad (value: Double) -> Double {
	return M_PI / 180.0 * value
}


public func rad2deg (value: Float) -> Float {
	return Float(180.0 / M_PI) * value
}


public func rad2deg (value: Double) -> Double {
	return 180.0 / M_PI * value
}


// VECTOR ----------------------------------------------------------

/**
Negates the vector

- parameter x: The vector to negate
:return: The negated vector
*/
public prefix func -<T: Vector> (x: T) -> T {
	var array : [GLfloat] = []
	
	let xArray : [GLfloat] = x.array
	for index in 0..<T.elementCount {
		array.append(-xArray[index])
	}
	
	return T(array)
}


/**
Adds two vectors

- parameter x: The first vector of the sum
- parameter y: The second vector of the sum
:return: The sum of both vectors
*/
public func +<T: Vector> (x: T, y: T) -> T {
	var array : [GLfloat] = []
	
	let xArray : [GLfloat] = x.array
	let yArray : [GLfloat] = y.array
	
	for index in 0..<T.elementCount {
		array.append(xArray[index] + yArray[index])
	}
	
	return T(array)
}


/**
Subtract two vectors

- parameter x: The first vector of the diff
- parameter y: The second vector of the diff
:return: The diff of both vectors
*/
public func +=<T: Vector> (x: T, y: T) -> T {
	return x + y
}


/**
Subtract two vectors

- parameter x: The first vector of the diff
- parameter y: The second vector of the diff
:return: The diff of both vectors
*/
public func -<T: Vector> (x: T, y: T) -> T {
	return x + -y
}


/**
Subtract two vectors

- parameter x: The first vector of the diff
- parameter y: The second vector of the diff
:return: The diff of both vectors
*/
public func -=<T: Vector> (x: T, y: T) -> T {
	return x - y
}


/**
Multiplies two vectors

- parameter x: The first vector of the product
- parameter y: The second vector of the product
:return: The component wise product of both vectors
*/
public func *<T: Vector> (x: T, y: T) -> T {
	var array : [GLfloat] = []
	
	let xArray : [GLfloat] = x.array
	let yArray : [GLfloat] = y.array
	
	for index in 0..<T.elementCount {
		array.append(xArray[index] * yArray[index])
	}
	
	return T(array)
}


/**
Multiplies a vector with a scalar

- parameter x: The vector of the product
- parameter y: The scalar of the product
:return: The component wise product
*/
public func *<T: Vector> (x: T, y: GLfloat) -> T {
	var array : [GLfloat] = []
	
	let xArray : [GLfloat] = x.array
	
	for index in 0..<T.elementCount {
		array.append(xArray[index] * y)
	}
	
	return T(array)
}


/**
Multiplies a vector with a scalar

- parameter x: The vector of the product
- parameter y: The scalar of the product
:return: The component wise product
*/
public func *<T: Vector> (x: GLfloat, y: T) -> T {
	return y * x
}


/**
The dot product of two vectors
*/
public func dot<T: Vector> (l: T, r: T) -> GLfloat {
	var product : GLfloat = 0
	
	for i in 0..<T.elementCount {
		product += l.array[i] * r.array[i]
	}
	
	return product
}

/**
Returns a orthonormal basis from three independent vectors
*/
public func gramschmidt<T: Vector>(a: T, vectors: T...) -> [T] {
	var basis : [T] = [a]
	for index in 0..<vectors.count {
		let w : T = vectors[index]
		for v in basis {
			w -= dot(v, r: w) / dot(v, r: v) * v
		}
		
		basis.append(w)
	}
	return basis
}


public func toString (mat: Matrix) -> String {
	var maxlen : Int = 0
	for element in mat.array {
		maxlen = max(maxlen, element.description.characters.count)
	}
	
	maxlen++
	
	var string : String = ""
	for row in 0..<mat.rows {
		let first : Float = mat[row, 0]
		string += "|" * (maxlen - first.description.characters.count - 1) + first.description
		for col in 1..<mat.cols {
			let element : Float = mat[row, col]
			string += " " * (maxlen - element.description.characters.count) + element.description
		}
		string += "|"
	}
	
	return string
}

/*
|--------------------------------------------------------------------------
| Protocols
|--------------------------------------------------------------------------
*/


public protocol Matrix : ListType, CustomStringConvertible {
	
	var rows : Int {get}
	
	var cols : Int {get}
	
	subscript (row: Int, col: Int) -> Float {get}
	
	init (_ list: [GLfloat])
	
	init ()
}


public protocol QuadraticMatrix : Matrix {
	var determinant : GLfloat {get}
}


public protocol Vector : Matrix {
	var magnitude : GLfloat {get}
}