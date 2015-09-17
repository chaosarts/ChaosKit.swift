//
//  GLGeometry.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/*
|--------------------------------------------------------------------------
| Protocols
|--------------------------------------------------------------------------
*/

/** 
Protocol for shape geometry
*/
public protocol GLGeometry : GLAttribute {
	
	/// Provides a lists of unique vertex positions
	var values : [vec3] {get}
		
	/// Describes the geometry as a list of int values, which indicates
	/// the index of the accoring vertex in `values`
	var indexlist : [Int] {get}
	
	/// Indicates if the vertice are shared (element array) or not (array)
	var sharedVertice : Bool {get}
	
	/// Provides the count of vertice, which are uploaded to the buffer,
	/// depending on `sharedVertice`
	var count : Int {get}
	
	/// Describes the geometry with line primitives. The order is given by `indexlist`
	var lines : [GLline] {get}
	
	/// Describes the geometry with triangle primitives. The order is given by `indexlist`
	var triangles : [GLtriangle] {get}
	
	
	/** 
	Appends a new value to the geometry
	
	- parameter value: The value to append
	- returns: The index of the new value or -1 if it has not been added
	*/
	mutating func append (value: vec3) -> Int
	
	
	/**
	Adds one or more values to the geometry
	
	- parameter values: A list of value to add to the geometry
	*/
	mutating func extend (values: [vec3])
	
	/**
	Returns the index of the value in the geometry
	*/
	func indexOf (value: vec3) -> Int?
}


/**
Reutrns a list of line primitves according to given geometry

- parameter geom: The geometry to get the line primitves from
- returns: A list of line primitives
*/
public func getLines (geom: GLGeometry) -> [GLline]{
	var lines : [GLline] = []
	var queue : Queue = Queue(geom.indexlist)
	repeat {
		let a : vec3 = geom.values[queue.dequeue()!]
		let b : vec3 = geom.values[queue.dequeue()!]
		lines.append(GLline(a, b))
	} while(queue.count > 1)
	
	return lines
}


/**
Returns the line in geometry with given index

- parameter geom: The geometry of the line primitive
- parameter index: The index of the line to obtain
- returns: The line primitve with given index
*/
public func getLine (geom: GLGeometry, index: Int) -> GLline? {
	let startIndex : Int = index * 2
	if startIndex + 1 >= geom.indexlist.count {return nil}
	
	let a : vec3 = geom.values[geom.indexlist[startIndex]]
	let b : vec3 = geom.values[geom.indexlist[startIndex + 1]]
	
	return GLline(a, b)
}

/**
Returns all lines, to which the given point belongs to

- parameter forPoint: The point for which to fetch the lines
:return: A list of all lines including the passed point
*/
public func getLines (geom: GLGeometry, point: vec3) -> [GLline] {
	let index : Int? = geom.values.indexOf(point)
	if nil == index {return []}
	
	var lines : [GLline] = []
	for i in 0..<geom.indexlist.count - 1 {
		if geom.indexlist[i] != index! {continue}
		let startIndex : Int = i - i % 2
		if startIndex + 1 >= geom.indexlist.count {break}
		
		let a : vec3 = geom.values[geom.indexlist[startIndex]]
		let b : vec3 = geom.values[geom.indexlist[startIndex + 1]]
		
		lines.append(GLline(a, b))
	}
	
	return lines
}


/**
Returns the triangle with given index

- parameter geom: The geometry to fetch the triangle from
- parameter index: The index of the triangle
:return: The triangle
*/
public func getTriangle (geom: GLGeometry, index: Int) -> GLtriangle? {
	let startIndex : Int = index * 3
	if startIndex + 2 >= geom.indexlist.count {return nil}
	
	let a : vec3 = geom.values[geom.indexlist[startIndex]]
	let b : vec3 = geom.values[geom.indexlist[startIndex + 1]]
	let c : vec3 = geom.values[geom.indexlist[startIndex + 2]]
	
	return GLtriangle(a, b, c)
}


/**
Returns all lines, to which the given point belongs to

- parameter forPoint: The point for which to fetch the lines
:return: A list of all lines including the passed point
*/
public func getTriangles (geom: GLGeometry, point: vec3) -> [GLtriangle] {
	let index : Int! = geom.values.indexOf(point)
	if nil == index {return []}
	
	var triangles : [GLtriangle] = []
	for i in 0..<geom.indexlist.count - 2 {
		if geom.indexlist[i] != index {continue}
		let startIndex : Int = i - i % 3
		if startIndex + 2 >= geom.indexlist.count {break}
		
		let a : vec3 = geom.values[geom.indexlist[startIndex]]
		let b : vec3 = geom.values[geom.indexlist[startIndex + 1]]
		let c : vec3 = geom.values[geom.indexlist[startIndex + 2]]
		
		triangles.append(GLtriangle(a, b, c))
	}
	return triangles
}
