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

:param: radius The radius of the sphere
:param: theta The angel between the vector and the y-axis
:param: phi The angel between the vector and the x-axis
*/
public func polar2cartesian (radius: GLfloat, theta: GLfloat, phi: GLfloat) -> vec3 {
	return vec3(radius * sin(theta) * sin(phi), radius * cos(theta), radius * sin(theta) * cos(phi))
}


/** 
Converts cartesian coordinates into polar coordinates around the zero vector
*/
public func cartesian2polar (position: vec3) -> (radius: GLfloat, theta: GLfloat, phi: GLfloat) {
	var radius : GLfloat = position.magnitude
	var theta : GLfloat = GLfloat(M_PI / 2) - atan(position.z / sqrt(position.x * position.x + position.y * position.y))
	var phi : GLfloat = atan2(position.x, position.y)
	
	return (radius, theta, phi)
}


public func restrict<C: Comparable> (value: C, minValue: C, maxValue: C) -> C {
	return max(minValue, min(maxValue, value))
}


public func deg2rad (value: Float) -> Float {
	return Float(M_PI / 180) * value
}


public func deg2rad (value: Double) -> Double {
	return M_PI / 180 * value
}


public func rad2deg (value: Float) -> Float {
	return Float(180 / M_PI) * value
}


public func rad2deg (value: Double) -> Double {
	return 180 / M_PI * value
}


// VECTOR ----------------------------------------------------------

/**
Negates the vector

:param: x The vector to negate
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

:param: x The first vector of the sum
:param: y The second vector of the sum
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

:param: x The first vector of the diff
:param: y The second vector of the diff
:return: The diff of both vectors
*/
public func +=<T: Vector> (x: T, y: T) -> T {
	return x + y
}


/**
Subtract two vectors

:param: x The first vector of the diff
:param: y The second vector of the diff
:return: The diff of both vectors
*/
public func -<T: Vector> (x: T, y: T) -> T {
	return x + -y
}


/**
Subtract two vectors

:param: x The first vector of the diff
:param: y The second vector of the diff
:return: The diff of both vectors
*/
public func -=<T: Vector> (x: T, y: T) -> T {
	return x - y
}


/**
Multiplies two vectors

:param: x The first vector of the product
:param: y The second vector of the product
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

:param: x The vector of the product
:param: y The scalar of the product
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

:param: x The vector of the product
:param: y The scalar of the product
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
		var w : T = vectors[index]
		for v in basis {
			w -= dot(v, w) / dot(v, v) * v
		}
		
		basis.append(w)
	}
	return basis
}

/*
|--------------------------------------------------------------------------
| Protocols
|--------------------------------------------------------------------------
*/


public protocol Matrix : ListType, Printable {
	static var rows : Int {get}
	static var cols : Int {get}
	init (_ list: [GLfloat])
	init ()
}


public protocol QuadraticMatrix : Matrix {
	var determinant : GLfloat {get}
}


public protocol Vector : Matrix {
	var magnitude : GLfloat {get}
//	subscript (index: Int) -> GLfloat {get}
//	init<T: Vector> (_ vec: T)
}