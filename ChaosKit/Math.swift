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
}


public protocol ListType : ArrayRepresentable, ArrayLiteralConvertible {
	static var elementCount : Int {get}
	init (_ list: [GLfloat])
	init ()
}


public protocol Matrix : ListType {	
	static var rows : Int {get}
	static var cols : Int {get}
}


public protocol QuadraticMatrix : Matrix {
	var determinant : GLfloat {get}
}


public protocol Vector : Matrix {
	var magnitude : GLfloat {get}
}