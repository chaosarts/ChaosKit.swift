//
//  GLSurface.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Surface struct for shapes
*/
public struct GLSurface {
	
	/// Provides the color of the surface
	public var color : GLShapeProperty?
	
	/// Provides the uniforms to apply to program when using this surface
	public var uniforms : [GLurl : GLUniform] {
		get {return [GLurl : GLUniform]()}
	}
	
	/// Provides the bufferable properties
	public var bufferables : [GLurl : GLBufferable] {
		get {
			var bufferables : [GLurl : GLBufferable] = [GLurl : GLBufferable]()
			if nil != color {bufferables[GLurl(.Vertex, GLAttributeType.Color)] = color!}
			return bufferables
		}
	}
}