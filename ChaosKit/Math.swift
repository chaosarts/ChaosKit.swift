//
//  Math.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 02.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

infix operator • {}

public func polar2cartesian (radius: GLfloat, theta: GLfloat, phi: GLfloat) -> vec3 {
	return vec3(radius * sin(theta) * sin(phi), radius * cos(theta), radius * sin(theta) * cos(phi))
}


public protocol ArrayRepresentable {
	static var byteSize : Int {get}
	
	var array : [GLfloat] {get}
	
	init ()

	init (_ array: [GLfloat])
}


public protocol ListType : ArrayRepresentable, ArrayLiteralConvertible {
	static var elementCount : Int {get}
	
}


public protocol ArithmeticType {
	prefix func - (l: Self) -> Self
	func + (l: Self, r: Self) -> Self
	func - (l: Self, r: Self) -> Self
	func * (l: Self, r: GLfloat) -> Self
	func * (l: GLfloat, r: Self) -> Self
}


public protocol MatrixType : ListType {	
	static var rows : Int {get}
	
	static var cols : Int {get}
}


public protocol QuadraticMatrixType : MatrixType {
	var determinant : GLfloat {get}
}


public protocol VectorType : MatrixType {
	
	typealias Type = Self
	
	var magnitude : GLfloat {get}
}