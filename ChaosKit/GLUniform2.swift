//
//  GLuniform2.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL
import OpenGL.GL
import OpenGL.GL3

/*
|--------------------------------------------------------------------------
| Single values
|--------------------------------------------------------------------------
*/

public struct GLuniform2d : GLUniform {
	
	private let _value : (x: GLdouble, y: GLdouble)
	
	public init (_ x: GLdouble, _ y: GLdouble) {
		_value = (x, y)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform2d(GLint(location.index), _value.x, _value.y)
	}
}


public struct GLuniform2f : GLUniform {
	
	private let _value : (x: GLfloat, y: GLfloat)
	
	public init (_ x: GLfloat, _ y: GLfloat) {
		_value = (x, y)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform2f(GLint(location.index), _value.x, _value.y)
	}
}


public struct GLuniform2i : GLUniform {
	
	private let _value : (x: GLint, y: GLint)
	
	public init (_ x: GLint, _ y: GLint) {
		_value = (x, y)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform2i(GLint(location.index), _value.x, _value.y)
	}
}


public struct GLuniform2ui : GLUniform {
	
	private let _value : (x: GLuint, y: GLuint)
	
	public init (_ x: GLuint, _ y: GLuint) {
		_value = (x, y)
	}
	
	public func assign (location: GLuniformloc) {
		glUniform2ui(GLint(location.index), _value.x, _value.y)
	}
}