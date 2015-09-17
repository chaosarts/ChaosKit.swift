//
//  GLSLvar.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 31.08.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public enum GLSLtype : String {
	case FLOAT = "float"
	case DOUBLE = "double"
	case VEC2 = "vec2"
	case VEC3 = "vec3"
	case VEC4 = "vec4"
	case MAT2 = "mat2"
	case MAT3 = "mat3"
	case MAT4 = "mat4"
	case SAMPLER = "sampler"
}

public struct GLSLvar {
	
	public let qualifier : GLSLqualifier
	
	public let name : String
	
	public init (qualifier: GLSLqualifier, name: String) {
		self.qualifier = qualifier
		self.name = name
	}
}