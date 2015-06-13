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
	
	/// Provides a list of different texture map types
	private var _texturemaps : [GLTextureMapType : GLSurfaceTexture] = [GLTextureMapType : GLSurfaceTexture]()
	
	/// Provides the color of the surface
	public var color : GLShapeProperty?
	
	/// Provides the surface normal of
	public var normal : GLShapeProperty?
	
	/// Provides the uniforms to apply to program when using this surface
	public var uniforms : [GLLocationSelector : GLUniform]  {
		get {
			var uniforms : [GLLocationSelector : GLUniform] = [GLLocationSelector : GLUniform] ()
			var count : GLint = 0
			for key in _texturemaps.keys {
				var selector : GLLocationSelector = GLLocationSelector(type: .Sampler, domain: key.rawValue)
				uniforms[selector] = GLUniform1i(GL_TEXTURE0 + count++)
			}
			return uniforms
		}
	}
	
	/// Provides the bufferable properties
	public var bufferables : [GLLocationSelector : GLBufferable] {
		get {
			var bufferables : [GLLocationSelector : GLBufferable] = [GLLocationSelector : GLBufferable]()
			if nil != normal {bufferables[GLLocationSelector(type: .Normal)] = normal!}
			if nil != color {bufferables[GLLocationSelector(type: .Color)] = color!}
			
			for key in _texturemaps.keys {
				var map : GLSurfaceTexture = _texturemaps[key]!
				var selector : GLLocationSelector = GLLocationSelector(type: .TexCoord, domain: key.rawValue)
				bufferables[selector] = map
			}
			return bufferables
		}
	}
}