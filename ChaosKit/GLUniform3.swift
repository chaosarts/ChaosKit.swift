//
//  GLuniform3.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL
import OpenGL.GL
import OpenGL.GL3


public struct GLuniform3d : GLUniform {
	
	private let _value : (x: GLdouble, y: GLdouble, z: GLdouble)
	
	public init (_ x: GLdouble, _ y: GLdouble, _ z: GLdouble) {
		_value = (x, y, z)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform3d(GLint(location.index), _value.x, _value.y, _value.z)
	}
}


public struct GLuniform3f : GLUniform {
	
	private let _value : (x: GLfloat, y: GLfloat, z: GLfloat)
	
	public init (_ x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
		_value = (x, y, z)
	}
	
	public init (_ vec: vec3) {
		self.init(vec.x, vec.y, vec.z)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform3f(GLint(location.index), _value.x, _value.y, _value.z)
	}
}


public struct GLuniform3i : GLUniform {
	
	private let _value : (x: GLint, y: GLint, z: GLint)
	
	public init (_ x: GLint, _ y: GLint, _ z: GLint) {
		_value = (x, y, z)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform3i(GLint(location.index), _value.x, _value.y, _value.z)
	}
}


public struct GLuniform3ui : GLUniform {
	
	private let _value : (x: GLuint, y: GLuint, z: GLuint)
	
	public init (_ x: GLuint, _ y: GLuint, z: GLuint) {
		_value = (x, y, z)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform3ui(GLint(location.index), _value.x, _value.y, _value.z)
	}
}