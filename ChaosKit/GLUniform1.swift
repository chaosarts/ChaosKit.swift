//
//  GLUniform1.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/*
|--------------------------------------------------------------------------
| Single values
|--------------------------------------------------------------------------
*/

public struct GLUniform1d : GLUniform {
	
	private let _value : GLdouble
	
	public init (_ value: GLdouble) {
		_value = value
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1d(GLint(location.id), _value)
	}
}


public struct GLUniform1f : GLUniform {
	
	private let _value : GLfloat
	
	public init (_ value: GLfloat) {
		_value = value
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1f(GLint(location.id), _value)
	}
}


public struct GLUniform1i : GLUniform {
	
	private let _value : GLint
	
	
	public init (_ value: GLint) {
		_value = value
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1i(GLint(location.id), _value)
	}
}


public struct GLUniform1ui : GLUniform {
	
	private let _value : GLuint
	
	
	public init (_ value: GLuint) {
		_value = value
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1ui(GLint(location.id), _value)
	}
}


/*
|--------------------------------------------------------------------------
| Arrays
|--------------------------------------------------------------------------
*/

public struct GLUniform1dv : GLUniform {
	
	private let _value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public init (_ value: [GLdouble]) {
		self.count = GLsizei(value.count)
		_value = toUnsafePointer(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1dv(GLint(location.id), count, _value)
	}
}


public struct GLUniform1fv : GLUniform {
	
	private let _value : UnsafePointer<GLfloat>
	
	public let count : GLsizei
	
	public init (_ value: [GLfloat]) {
		self.count = GLsizei(value.count)
		_value = toUnsafePointer(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1fv(GLint(location.id), count, _value)
	}
}


public struct GLUniform1iv : GLUniform {
	
	private let _value : UnsafePointer<GLint>
	
	public let count : GLsizei
	
	public init (_ value: [GLint]) {
		self.count = GLsizei(value.count)
		_value = toUnsafePointer(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1iv(GLint(location.id), count, _value)
	}
}


public struct GLUniform1uiv : GLUniform {
	
	private let _value : UnsafePointer<GLuint>
	
	public let count : GLsizei
	
	public init (_ value: [GLuint]) {
		self.count = GLsizei(value.count)
		_value = toUnsafePointer(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1uiv(GLint(location.id), count, _value)
	}
}