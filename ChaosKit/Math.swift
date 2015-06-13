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