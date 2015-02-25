//
//  Math.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 02.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

infix operator • {}


public protocol ArrayRepresentable {
	class var byteSize : Int {get}
	
	var array : [GLfloat] {get}
	
	init ()

	init (_ array: [GLfloat])
}


public protocol ListType : ArrayRepresentable, ArrayLiteralConvertible {
	class var elementCount : Int {get}
	
}


public protocol ArithmeticType {
	prefix func - (l: Self) -> Self
	func + (l: Self, r: Self) -> Self
	func - (l: Self, r: Self) -> Self
	func * (l: Self, r: GLfloat) -> Self
	func * (l: GLfloat, r: Self) -> Self
}


public protocol MatrixType : ListType {
	
	class var rows : Int {get}
	
	class var cols : Int {get}
}


public protocol QuadraticMatrixType : MatrixType {
	var transposed : Self {get}
	
	var determinant : GLfloat {get}
}


public protocol VectorType : MatrixType {
	var magnitude : GLfloat {get}
}