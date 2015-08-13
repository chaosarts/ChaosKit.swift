//
//  GLSurfaceNormal.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Struct that stores the normals of a surface
*/
public struct GLnormal : GLAttribute, ArrayLiteralConvertible {
	
	/// Provides a list of normal vectors
	public private(set) var values : [vec3] = []
	
	/// Inidcates if the attribute is dynamic or static
	public var dynamic : Bool = false
	
	/// Provides the attribute size per vertex
	public var size : Int {get {return 3}}
	
	
	// SUBSCRIPTS
	// ++++++++++
	
	
	public subscript () -> vec3 {
		get {return vec3()}
		set {values.append(newValue)}
	}
	
	
	public subscript (index: Int) -> vec3 {
		get {return values[index]}
		set {values[index] = newValue}
	}
	
	
	// INITIALIZERS
	// ++++++++++++
	
	
	public init (_ values: [vec3]) {
		self.values = values
	}
	
	
	public init (arrayLiteral elements: vec3...) {
		self.init(elements)
	}
	
	
	public init () {
		self.init([])
	}
	
	/** 
	Initializes the attribute by deriving the normals from geometry
	
	:param: geom The geometry to use to generate the attribute values
	*/
	public init (_ geom: GLGeometry) {		
		if geom.sharedVertice {
			for value in geom.values {
				let triangles : [GLtriangle] = GLtriangle.fromGeometry(geom, value)
				var normal : vec3 = vec3()
				for triangle in triangles {
					normal = normal + triangle.normal
				}
				
				values.append(normal * (1.0 / Float(triangles.count)))
			}
		}
		else {
			let triangles : [GLtriangle] = geom.triangles
			for triangle in triangles {
				let normal : vec3 = triangle.normal
				values.extend([normal, normal, normal])
			}
		}
	}
	
	
	// METHODS
	// +++++++
	
	/**
	Returns the attribute for a vertex at given index as float array
	
	:param: atIndex The index of the attribute value to obtain
	:returns: The attribute value of the vertex at given index
	*/
	public func getBufferData(atIndex index: Int) -> [GLfloat] {
		return values[index].array
	}
}