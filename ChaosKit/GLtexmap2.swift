//
//  GLTextureMap.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 08.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

///
public struct GLtexmap2 : GLTextureMap2D {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides the texture to use for texture mapping
	public private(set) var texture : GLTexImage2D
	
	/// Provides the texture coordinates for texture mapping
	public private(set) var values : [vec2]
	
	/// Indicates whether the coords a re used for dynamic or static draw
	public var dynamic : Bool = false
	
	/// Provides the tangent of the tangent space
	public private(set) var tangent : GLvarattrib3?
	
	/// Provides the bitangent of the tangent space
	public private(set) var bitangent : GLvarattrib3?

	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the attribute size of one vertex
	public var size : Int {get {return 2}}
	
	
	// SUBSCIPTS
	// +++++++++
	
	/**
	Used to append new texture cooridnates
	*/
	public subscript () -> vec2 {
		get {return vec2()}
		set {values.append(newValue)}
	}
	
	
	// INITIALIZERS
	// ++++++++++++
	
	/**
	Initializes the text map
	
	- parameter texture: The texture to use for mapping
	- parameter coords: The texture coordinates of the vertice
	*/
	public init (_ texture: GLTexImage2D, _ coords : [vec2]) {
		self.texture = texture
		self.values = coords
	}
	
	
	/**
	Initializes the text map without texture coordinates
	
	- parameter texture: The texture to use for mapping
	*/
	public init (_ texture: GLTexImage2D) {
		self.init(texture, [])
	}
	
	
	// METHODS
	// +++++++
	
	/**
	Returns the buffer data for the vertex at given index
	
	- parameter atIndex: The index of the vertex to get the data from
	- returns: The buffer data as float list
	*/
	public func getBufferData (atIndex index: Int) -> [GLfloat] {
		return values[index].array
	}
	
	
	public mutating func genTangent (geom: GLGeometry) {
		self.tangent = GLvarattrib<vec3>()
		self.bitangent = GLvarattrib<vec3>()
		if geom.sharedVertice {
			for index in 0..<geom.values.count {
				let triangles : [GLtriangle] = GLtriangle.fromGeometry(geom, geom.values[index])
				var tangent : vec3 = vec3()
				var bitangent : vec3 = vec3()
				
				for triangle in triangles {
					let index1 : Int = geom.indexOf(triangle.a)!
					let index2 : Int = geom.indexOf(triangle.b)!
					let index3 : Int = geom.indexOf(triangle.c)!
					let texcoord1 : vec2 = values[index1]
					let texcoord2 : vec2 = values[index2]
					let texcoord3 : vec2 = values[index3]
					
					let tbn : GLtbn = GLtbn(
						triangle.normal, triangle.a, triangle.b, triangle.c,
						texcoord1, texcoord2, texcoord3
					)
					
					tangent = tangent + tbn.tangent
					bitangent = bitangent + tbn.bitangent
				}
				tangent = tangent / Float(geom.values.count)
				bitangent = bitangent / Float(geom.values.count)
				self.tangent!.append(tangent)
				self.bitangent!.append(bitangent)
			}
		}
		else {
			let triangles : [GLtriangle] = geom.triangles
			var index : Int = 0
			for triangle in triangles {
				let texcoord1 : vec2 = values[index]
				let texcoord2 : vec2 = values[index + 1]
				let texcoord3 : vec2 = values[index + 2]
				
				let tbn : GLtbn = GLtbn(
					triangle.normal, triangle.a, triangle.b, triangle.c,
					texcoord1, texcoord2, texcoord3
				)
				
				index += 3
				
				self.tangent!.extend([tbn.tangent, tbn.tangent, tbn.tangent])
				self.bitangent!.extend([tbn.bitangent, tbn.bitangent, tbn.bitangent])
			}
		}
	}
}