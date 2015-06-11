//
//  File.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 24.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLUniform {
	func assign (location: GLUniformLocation)
}


/*
|--------------------------------------------------------------------------
| Matrices
|--------------------------------------------------------------------------
*/


public struct GLUniformMatrix2fv : GLUniform {
	
	private let _value : UnsafePointer<GLfloat>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	public init (value: mat2, transpose: Bool = false) {
		_value = toUnsafePointer(value.array)
		self.count = 1
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [mat2], transpose: Bool = false) {
		
		var array : [GLfloat] = []
		for i in 0..<value.count {array += value[i].array}
		
		_value = toUnsafePointer(array)
		self.count = GLsizei(value.count)
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [GLfloat], count: GLsizei, transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix2fv(GLint(location.id), count, transpose, _value)
	}
}


public struct GLUniformMatrix2dv : GLUniform {
	
	private let _value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	
	public init (value: [GLdouble], count: GLsizei, transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix2dv(GLint(location.id), count, transpose, _value)
	}
}


public struct GLUniformMatrix3fv : GLUniform {
	
	private let _value : UnsafePointer<GLfloat>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	public init (value: mat3, transpose: Bool = false) {
		_value = toUnsafePointer(value.array)
		self.count = 1
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [mat3], transpose: Bool = false) {
		
		var array : [GLfloat] = []
		for i in 0..<value.count {array += value[i].array}
		
		_value = toUnsafePointer(array)
		self.count = GLsizei(value.count)
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [GLfloat], count: GLsizei, transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix3fv(GLint(location.id), count, transpose, _value)
	}
}


public struct GLUniformMatrix3dv : GLUniform {
	
	private let _value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	
	public init (value: [GLdouble], count: GLsizei, transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix3dv(GLint(location.id), count, transpose, _value)
	}
}


public struct GLUniformMatrix4fv : GLUniform {
	
	private let _value : UnsafePointer<GLfloat>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	public init (value: mat4, transpose: Bool = false) {
		_value = toUnsafePointer(value.array)
		self.count = 1
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [mat4], transpose: Bool = false) {
		
		var array : [GLfloat] = []
		for i in 0..<value.count {array += value[i].array}
		
		_value = toUnsafePointer(array)
		self.count = GLsizei(value.count)
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [GLfloat], count: GLsizei, transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix4fv(GLint(location.id), count, transpose, _value)
	}
}


public struct GLUniformMatrix4dv : GLUniform {
	
	private let _value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	
	public init (value: [GLdouble], count: GLsizei, transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix4dv(GLint(location.id), count, transpose, _value)
	}
}
