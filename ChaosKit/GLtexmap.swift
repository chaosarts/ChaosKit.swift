//
//  GLTextureMap.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 08.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

///
public struct GLtexmap<V: Vector> : GLTextureMap {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides the texture to use for texture mapping
	public private(set) var texture : GLTexture
	
	/// Provides the texture coordinates for texture mapping
	public private(set) var values : [V]
	
	/// Indicates whether the coords a re used for dynamic or static draw
	public var dynamic : Bool = false
	
	/// Provides the tangent of the tangent space
	public private(set) var tangent : GLvarattrib4?

	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the attribute size of one vertex
	public var size : Int {get {return V.elementCount}}
	
	
	// SUBSCIPTS
	// +++++++++
	
	/**
	Used to append new texture cooridnates
	*/
	public subscript () -> V {
		get {return V()}
		set {values.append(newValue)}
	}
	
	
	// INITIALIZERS
	// ++++++++++++
	
	/**
	Initializes the text map
	
	:param: texture The texture to use for mapping
	:param: coords The texture coordinates of the vertice
	*/
	public init (_ texture: GLTexture, _ coords : [V]) {
		self.texture = texture
		self.values = coords
	}
	
	
	/**
	Initializes the text map without texture coordinates
	
	:param: texture The texture to use for mapping
	*/
	public init (_ texture: GLTexture) {
		self.init(texture, [])
	}
	
	
	// METHODS
	// +++++++
	
	/**
	Returns the buffer data for the vertex at given index
	
	:param: atIndex The index of the vertex to get the data from
	:returns: The buffer data as float list
	*/
	public func getBufferData (atIndex index: Int) -> [GLfloat] {
		return values[index].array
	}
}

public typealias GLtexmap1 = GLtexmap<vec1>
public typealias GLtexmap2 = GLtexmap<vec2>
public typealias GLtexmap3 = GLtexmap<vec3>