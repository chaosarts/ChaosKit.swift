//
//  mat2x3.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 10.09.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Struct for 2x3 matrices.
*/
public struct mat2x3 : Matrix {
	
	public typealias Type = mat2x3
	
	// STATIC PROPETIES
	// ****************
	
	/// Provides the count of rows of the matrix
	public static var rows : Int {get {return 2}}
	
	/// Provides the count of cols of the matrix
	public static var cols : Int {get {return 3}}
	
	/// Indicates the count of elements, the matrix consists of
	public static var elementCount : Int {get {return rows * cols}}
	
	
	// STORED PROPERTIES
	// *****************
	
	// Provides the matrix as array. The values are column major stored
	public private(set) var array : [Float] = Array(count: mat2x3.elementCount, repeatedValue: 0.0)
	
	
	// DERIVED PROPERTIES
	// ******************
	
	/// Provides the count of rows of the matrix
	public var rows : Int {get {return 2}}
	
	/// Provides the count of cols of the matrix
	public var cols : Int {get {return 3}}
	
	/// Provides the description of the matrix
	public var description : String {get {return toString(self)}}
	
	
	// SUBSCRIPTS
	// **********
	
	/// Returns the row vector of the matrix at given index
	public subscript (row index: Int) -> vec3 {
		get {return vec3(array[index], array[index + 2], array[index + 4])}
		set {
			array[index] = newValue.x
			array[index + 2] = newValue.y
			array[index + 4] = newValue.z
		}
	}
	
	
	/// Returns the row vector of the matrix at given index
	public subscript (col index: Int) -> vec2 {
		get {
			let startIndex : Int = index * mat2x3.rows
			return vec2(array[startIndex], array[startIndex + 1])
		}
		
		set {
			let startIndex : Int = index * mat2x3.rows
			array[startIndex] = newValue.x
			array[startIndex + 1] = newValue.y
		}
	}
	
	
	/// Access the value at given row and column
	public subscript (row: Int, col: Int) -> Float {
		get {return array[col * mat2x3.rows + row]}
		set {array[col * mat2x3.rows + row] = newValue}
	}
	
	
	// INITIAIZERS
	// ***********
	
	/// Initializes the matrix with given array
	public init (_ list: [GLfloat]) {
		let max : Int = min(mat2x3.elementCount, list.count)
		for i in 0..<max {array[i] = list[i]}
	}
	
	
	/// Initializes the zero matrix
	public init () {}
}