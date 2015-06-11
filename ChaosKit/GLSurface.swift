//
//  GLSurface.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLSurface {
	
	private var _texturemaps : [GLTextureMapType : GLSurfaceTexture] = [GLTextureMapType : GLSurfaceTexture]()
	
	public var color : GLShapeProperty = GLSurfaceRGBAColorArray()
	
	public var normal : GLShapeProperty = GLSurfaceNormal3DArray()
	
	public var bufferables : [GLLocationSelector : GLBufferable] {
		get {
			var output : [GLLocationSelector : GLBufferable] = [GLLocationSelector : GLBufferable]()
			output[GLLocationSelector(type: .Normal)] = normal
			output[GLLocationSelector(type: .Color)] = color
			
			for key in _texturemaps.keys {
				var map : GLSurfaceTexture = _texturemaps[key]!
				var selector : GLLocationSelector = GLLocationSelector(type: .TexCoord, domain: key.rawValue)
				output[selector] = map
			}
			return output
		}
	}
}