//
//  GLUniform.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public enum GLUniformAlias {
	case ModelViewMatrix
	case ProjectionViewMatrix
	
	case AmbientLightColor
	case AmbientLightIntensity
	
	case DiffuseLightColor
	case DiffuseLightPosition
	case DiffuseLightIntensity
	
	case SpecularLightColor
	case SpecularLightPosition
	case SpecularLightIntensity
	case SpecularLightShininess
}


public struct GLUniformVariable {
	
	public let id : GLuint
	
	public let name : String
	
	public let type : GLenum
	
	public let size : GLint
	
	
	public init (index: GLuint, name: String, type: GLenum, size: GLint) {
		self.id = index
		self.name = name
		self.type = type
		self.size = size
	}
}
