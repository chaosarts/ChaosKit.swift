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
| Single values
|--------------------------------------------------------------------------
*/

public struct GLUniform1d : GLUniform {
	
	public let value : GLdouble
	
	
	public init (value: GLdouble) {
		self.value = value
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1d(GLint(location.id), value)
	}
}


public struct GLUniform1f : GLUniform {
	
	public let value : GLfloat
	
	
	public init (value: GLfloat) {
		self.value = value
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1f(GLint(location.id), value)
	}
}


public struct GLUniform1i : GLUniform {
	
	public let value : GLint
	
	
	public init (value: GLint) {
		self.value = value
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1i(GLint(location.id), value)
	}
}


public struct GLUniform1ui : GLUniform {
	
	public let value : GLuint
	
	
	public init (value: GLuint) {
		self.value = value
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1ui(GLint(location.id), value)
	}
}


/*
|--------------------------------------------------------------------------
| Arrays
|--------------------------------------------------------------------------
*/

public struct GLUniform1dv : GLUniform {
	
	public let value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public init (value: [GLdouble]) {
		self.count = GLsizei(value.count)
		self.value = toUnsafePointer(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1dv(GLint(location.id), count, value)
	}
}


public struct GLUniform1fv : GLUniform {
	
	public let value : UnsafePointer<GLfloat>
	
	public let count : GLsizei
	
	public init (value: [GLfloat]) {
		self.count = GLsizei(value.count)
		self.value = toUnsafePointer(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1fv(GLint(location.id), count, value)
	}
}


public struct GLUniform1iv : GLUniform {
	
	public let value : UnsafePointer<GLint>
	
	public let count : GLsizei
	
	public init (value: [GLint]) {
		self.count = GLsizei(value.count)
		self.value = toUnsafePointer(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1iv(GLint(location.id), count, value)
	}
}


public struct GLUniform1uiv : GLUniform {
	
	public let value : UnsafePointer<GLuint>
	
	public let count : GLsizei
	
	public init (value: [GLuint]) {
		self.count = GLsizei(value.count)
		self.value = toUnsafePointer(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1uiv(GLint(location.id), count, value)
	}
}


/*
|--------------------------------------------------------------------------
| Matrices
|--------------------------------------------------------------------------
*/


public struct GLUniformMatrix2fv : GLUniform {
	
	public let value : UnsafePointer<GLfloat>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	public init (value: mat2, transpose: Bool = false) {
		self.value = toUnsafePointer(value.array)
		self.count = 1
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [mat2], transpose: Bool = false) {
		
		var array : [GLfloat] = []
		for i in 0..<value.count {array += value[i].array}
		
		self.value = toUnsafePointer(array)
		self.count = GLsizei(value.count)
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [GLfloat], count: GLsizei, transpose: Bool = true) {
		self.value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix2fv(GLint(location.id), count, transpose, value)
	}
}


public struct GLUniformMatrix2dv : GLUniform {
	
	public let value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	
	public init (value: [GLdouble], count: GLsizei, transpose: Bool = true) {
		self.value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix2dv(GLint(location.id), count, transpose, value)
	}
}


public struct GLUniformMatrix3fv : GLUniform {
	
	public let value : UnsafePointer<GLfloat>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	public init (value: mat3, transpose: Bool = false) {
		self.value = toUnsafePointer(value.array)
		self.count = 1
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [mat3], transpose: Bool = false) {
		
		var array : [GLfloat] = []
		for i in 0..<value.count {array += value[i].array}
		
		self.value = toUnsafePointer(array)
		self.count = GLsizei(value.count)
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [GLfloat], count: GLsizei, transpose: Bool = true) {
		self.value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix3fv(GLint(location.id), count, transpose, value)
	}
}


public struct GLUniformMatrix3dv : GLUniform {
	
	public let value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	
	public init (value: [GLdouble], count: GLsizei, transpose: Bool = true) {
		self.value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix3dv(GLint(location.id), count, transpose, value)
	}
}


public struct GLUniformMatrix4fv : GLUniform {
	
	public let value : UnsafePointer<GLfloat>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	public init (value: mat4, transpose: Bool = false) {
		self.value = toUnsafePointer(value.array)
		self.count = 1
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [mat4], transpose: Bool = false) {
		
		var array : [GLfloat] = []
		for i in 0..<value.count {array += value[i].array}
		
		self.value = toUnsafePointer(array)
		self.count = GLsizei(value.count)
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	
	public init (value: [GLfloat], count: GLsizei, transpose: Bool = true) {
		self.value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix4fv(GLint(location.id), count, transpose, value)
	}
}


public struct GLUniformMatrix4dv : GLUniform {
	
	public let value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	
	public init (value: [GLdouble], count: GLsizei, transpose: Bool = true) {
		self.value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniformMatrix4dv(GLint(location.id), count, transpose, value)
	}
}
