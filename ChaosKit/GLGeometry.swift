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
public protocol GLGeometry : GLShapeProperty {
	
	/// Indicates the count of vertices the geometry contains
	var count : Int {mutating get}
	
	/// Indicates wether the geometry uses shared vertices or not
	var indexed : Bool {get}
	
	/// Provides the list of indices
	var indexlist : [Int]? {get}
	
	/// Provides the normals of the geometry
	var normals : GLShapeProperty? {mutating get}
}