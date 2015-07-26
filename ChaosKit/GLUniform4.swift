//
//  GLuniform4.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL
import OpenGL.GL
import OpenGL.GL3


public struct GLuniform4d : GLUniform {
	
	private let _value : (x: GLdouble, y: GLdouble, z: GLdouble, w: GLdouble)
	
	public init (_ x: GLdouble, _ y: GLdouble, z: GLdouble, w: GLdouble) {
		_value = (x, y, z, w)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform4d(GLint(location.index), _value.x, _value.y, _value.z, _value.w)
	}
}


public struct GLuniform4f : GLUniform {
	
	private let _value : (x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat)
	
	public init (_ x: GLfloat, _ y: GLfloat, _ z: GLfloat, _ w: GLfloat) {
		_value = (x, y, z, w)
	}
	
	public init (_ value : vec4) {
		self.init(value.x, value.y, value.z, value.w)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform4f(GLint(location.index), _value.x, _value.y, _value.z, _value.w)
	}
}


public struct GLuniform4i : GLUniform {
	
	private let _value : (x: GLint, y: GLint, z: GLint, w: GLint)
	
	public init (_ x: GLint, _ y: GLint, z: GLint, w: GLint) {
		_value = (x, y, z, w)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform4i(GLint(location.index), _value.x, _value.y, _value.z, _value.w)
	}
}


public struct GLuniform4ui : GLUniform {
	
	private let _value : (x: GLuint, y: GLuint, z: GLuint, w: GLuint)
	
	public init (_ x: GLuint, _ y: GLuint, z: GLuint, w: GLuint) {
		_value = (x, y, z, w)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform4ui(GLint(location.index), _value.x, _value.y, _value.z, _value.w)
	}
}