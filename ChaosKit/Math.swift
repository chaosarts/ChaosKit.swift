//
//  Math.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 02.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

infix operator • {}

public protocol vector : Equatable, ArrayLiteralConvertible {
	var array : [GLfloat] {get}
	
	var magnitude : GLfloat {get}
	
	prefix func - (l: Self) -> Self
	func + (l: Self, r: Self) -> Self
	func - (l: Self, r: Self) -> Self
	func * (l: Self, r: Self) -> GLfloat
	func * (l: Self, r: GLfloat) -> Self
	func * (l: GLfloat, r: Self) -> Self
}