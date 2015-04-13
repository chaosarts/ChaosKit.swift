//
//  GLTextureMap.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLTextureMap {
	
	public var texture : GLTexture
	
	public var type : GLTextureMapType
	
	public convenience init (_ texture: GLTexture) {
		self.init(texture, .Image)
	}
	
	public init (_ texture: GLTexture, _ type: GLTextureMapType) {
		self.texture = texture
		self.type = type
	}
}


public enum GLTextureMapType : String {
	case Image = "GLTextureMapType.Image"
	case Diffuse = "GLTextureMapType.Diffuse"
	case Normal = "GLTextureMapType.Normal"
	case Bump = "GLTextureMapType.Bump"
	case Height = "GLTextureMapType.Height"
	case Displacement = "GLTextureMapType.Displacement"
	case Specular = "GLTextureMapType.Specular"
	case Glow = "GLTextureMapType.Glow"
}