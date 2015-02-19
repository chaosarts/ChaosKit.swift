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
	var array : [GLfloat] {get}
}


public protocol ListType : ArrayRepresentable {
	class var elementCount : UInt {get}
}


public protocol ArithmeticType {
	prefix func - (l: Self) -> Self
	func + (l: Self, r: Self) -> Self
	func - (l: Self, r: Self) -> Self
	func * (l: Self, r: GLfloat) -> Self
	func * (l: GLfloat, r: Self) -> Self
}


public protocol MatrixType : ListType {
	
	class var rows : UInt {get}
	
	class var cols : UInt {get}
}


public protocol QuadraticMatrixType : MatrixType {
	var transposed : Self {get}
	
	var determinant : GLfloat {get}
}


public protocol VectorType : MatrixType {
	var magnitude : GLfloat {get}
}