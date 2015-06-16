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
	var count : Int {get}
	
	/// Indicates wether the geometry uses shared vertices or not
	var indexed : Bool {get}
	
	/// Provides the list of indices
	var indexlist : [Int]? {get}
	
	/// Provides the normals of the geometry
	var normals : GLShapeProperty? {get}
}


/*
|--------------------------------------------------------------------------
| Structs
|--------------------------------------------------------------------------
*/

/**
A GLGeometry struct as array
*/
public struct GLGeometryArray<V: Vector> : GLGeometry, ArrayLiteralConvertible {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides the vertex position to index
	private var _indexMap : [String : Int]?
	
	/// Provides a list of positions of the geometry
	public private(set) var values : [V] = []
	
	/// Indicates whether the vertices change often or not
	public var dynamic : Bool = false
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the size of a vertex
	public var size : Int {get {return V.elementCount}}
	
	/// Indicates the count of vertices the geoemtry contains
	public var count : Int {get {return values.count}}
	
	/// Indicates wether the geometry uses shared vertices or not
	public var indexed : Bool {get {return nil != _indexMap}}
	
	/// Provides the index list if geometry uses shared vertices
	public private(set) var indexlist : [Int]?
	
	/// Provides the normals of the geometry
	public var normals : GLShapeProperty?
	
	
	// SUBSCRIPTS
	// ++++++++++
	
	///
	public subscript () -> V {
		get {return V()}
		set {
			if !indexed {values.append(newValue); return}
			if indexlist == nil {indexlist = []}
			
			var index : Int? = _indexMap![newValue.description]
			if index == nil {
				index = count
				_indexMap![newValue.description] = count
				values.append(newValue)
			}
			
			indexlist!.append(index!)
		}
	}
	
	
	/// Returns the vertex at given index as array of float
	public subscript (index: Int) -> [GLfloat] {
		get {return values[index].array}
	}
	
	
	// INITIALIZERS
	// ++++++++++++
	
	/**
	Initializes the geoemtry with passed values
	*/
	public init (_ values: [V], _ indexed: Bool = false) {
		self.values = values
		if indexed {
			_indexMap = [String : Int]()
			indexlist = []
		}
	}
	
	
	public init (_ indexed: Bool = false) {
		self.init([], indexed)
	}
	
	
	public init(arrayLiteral elements: V...) {
		self.init(elements)
	}
}


/*
|--------------------------------------------------------------------------
| Typealias
|--------------------------------------------------------------------------
*/

public typealias GLGeometry2DArray = GLGeometryArray<vec2>
public typealias GLGeometry3DArray = GLGeometryArray<vec3>
public typealias GLGeometry4DArray = GLGeometryArray<vec4>