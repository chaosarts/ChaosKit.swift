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
		
	/// Provides the list of indices
	var indexlist : [Int] {get}
	
	/// Provides the list of vertice
	var values : [vec3] {get}
	
	/** 
	Appends a new value to the geometry
	
	:param: value The value to append
	*/
	mutating func append (value: vec3) -> Int
	
	
	/**
	Adds one or more values to the geometry
	
	:param: values A list of value to add to the geometry
	*/
	mutating func extend (values: [vec3])
}