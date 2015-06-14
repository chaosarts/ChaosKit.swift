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
	
	/// Provides the surface normal of
	public var normal : GLShapeProperty?
	
	/// Provides the uniforms to apply to program when using this surface
	public var uniforms : [GLUrl : GLUniform] {
		get {return [GLUrl : GLUniform]()}
	}
	
	/// Provides the bufferable properties
	public var bufferables : [GLUrl : GLBufferable] {
		get {
			var bufferables : [GLUrl : GLBufferable] = [GLUrl : GLBufferable]()
			if nil != normal {bufferables[GLUrl(.Vertex, .Normal)] = normal!}
			if nil != color {bufferables[GLUrl(.Vertex, GLAttributeType.Color)] = color!}
			
//			for key in _texturemaps.keys {
//				var map : GLSurfaceTexture = _texturemaps[key]!
//				var selector : GLUrl = GLUrl(type: .TexCoord, domain: key.rawValue)
//				bufferables[selector] = map
//			}
			return bufferables
		}
	}
}