//
//  GLtangent.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.08.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Struct that stores the normals of a surface
*/
public struct GLtangent : GLAttribute, ArrayLiteralConvertible {
	
	/// Provides a list of normal vectors
	public private(set) var values : [vec4] = []
	
	/// Inidcates if the attribute is dynamic or static
	public var dynamic : Bool = false
	
	/// Provides the attribute size per vertex
	public var size : Int {get {return 3}}
	
	
	// SUBSCRIPTS
	// ++++++++++
	
	
	public subscript () -> vec4 {
		get {return vec4()}
		set {values.append(newValue)}
	}
	
	
	public subscript (index: Int) -> vec4 {
		get {return values[index]}
		set {values[index] = newValue}
	}
	
	
	// INITIALIZERS
	// ++++++++++++
	
	
	public init (_ values: [vec4]) {
		self.values = values
	}
	
	
	public init (arrayLiteral elements: vec4...) {
		self.init(elements)
	}
	
	
	public init () {
		self.init([])
	}
	
	/**
	Initializes the attribute by deriving the normals from geometry
	
	:param: geom The geometry to use to generate the attribute values
	*/
	public init (_ geom: GLGeometry, _ texmap: GLtexmap2) {
		if geom.sharedVertice {
			for index in 0..<geom.values.count {
				let triangles : [GLtriangle] = GLtriangle.fromGeometry(geom, geom.values[index])
				var tangent : vec4 = vec4()
				for triangle in triangles {
					let index1 : Int = geom.indexOf(triangle.a)!
					let index2 : Int = geom.indexOf(triangle.b)!
					let index3 : Int = geom.indexOf(triangle.c)!
					let texcoord1 : vec2 = texmap.values[index1]
					let texcoord2 : vec2 = texmap.values[index2]
					let texcoord3 : vec2 = texmap.values[index3]
					
					let tspace : GLtangentspace = triangle.getTangentSpace(texcoord1, texcoord2, texcoord3)!.orthonormalized
					tangent = tangent + vec4(tspace.t, tspace.positive ? 1.0 : -1.0)
				}
				tangent.w = tangent.w < 0.0 ? -1.0 : 1.0
				values.append(tangent * (1.0 / Float(geom.values.count)))
			}
		}
		else {
			let triangles : [GLtriangle] = geom.triangles
			for triangle in triangles {
				
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