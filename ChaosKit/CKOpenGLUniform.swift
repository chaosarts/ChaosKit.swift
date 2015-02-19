//
//  CKOpenGLUniform.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public enum CKOpenGLUniformType {
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

public struct CKOpenGLUniformInfo {
	
	public let name : String
	
	public let target : CKOpenGLUniformType
	
	public var type : GLenum?
	
	public var size : GLint?
	
	public var location : GLint = -1
	
	public var locations : [GLint] = []
	
	
	subscript (index: Int) -> GLint {
		get {
			assert(valid(index), "Bad index access for uniform")
			return locations[index]
		}
		
		set {
			assert(valid(index), "Bad index access for uniform")
			locations[index] = newValue
		}
	}
	
	public init (name: String, target: CKOpenGLUniformType) {
		self.name = name
		self.target = target
	}
	
	
	private func valid (index: Int) -> Bool {
		return nil != size && index > 0 && index < Int(size!)
	}
}
