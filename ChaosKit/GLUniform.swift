//
//  File.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 24.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

public protocol GLUniform {
	func assign (location: GLuniformloc)
}


/*
|--------------------------------------------------------------------------
| Matrices
|--------------------------------------------------------------------------
*/


public struct GLuniformMat2fv : GLUniform {
	
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
	
	public func assign (location: GLuniformloc) {
		glUniformMatrix2fv(GLint(location.index), count, transpose, _value)
	}
}


public struct GLuniformMat2dv : GLUniform {
	
	private let _value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	
	public init (value: [GLdouble], count: GLsizei, transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLuniformloc) {
		glUniformMatrix2dv(GLint(location.index), count, transpose, _value)
	}
}


public struct GLuniformMat3fv : GLUniform {
	
	private let _value : UnsafePointer<GLfloat>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	public init (_ value: [GLfloat], _ count: GLsizei, _ transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public init (_ value: mat3, _ transpose: Bool = false) {
		self.init(value.array, 1, transpose)
	}
	
	
	public init (_ value: [mat3], _ transpose: Bool = false) {
		var array : [GLfloat] = []
		for i in 0..<value.count {array += value[i].array}
		self.init(array, GLsizei(value.count), transpose)
	}
	
	public func assign (location: GLuniformloc) {
		glUniformMatrix3fv(GLint(location.index), count, transpose, _value)
	}
}


public struct GLuniformMat3dv : GLUniform {
	
	private let _value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	
	public init (value: [GLdouble], count: GLsizei, transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLuniformloc) {
		glUniformMatrix3dv(GLint(location.index), count, transpose, _value)
	}
}


public struct GLuniformMat4fv : GLUniform {
	
	private let _value : UnsafePointer<GLfloat>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	
	public init (_ value: [GLfloat], _ count: GLsizei, _ transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public init (_ value: [mat4]) {
		var array : [GLfloat] = []
		for i in 0..<value.count {array += value[i].array}
		self.init(array, GLsizei(value.count), false)
	}
	
	public init (_ value: mat4) {
		self.init([value])
	}
	
	public func assign (location: GLuniformloc) {
		glUniformMatrix4fv(GLint(location.index), count, transpose, _value)
	}
}


public struct GLuniformMat4dv : GLUniform {
	
	private let _value : UnsafePointer<GLdouble>
	
	public let count : GLsizei
	
	public let transpose : GLboolean
	
	
	public init (value: [GLdouble], count: GLsizei, transpose: Bool = true) {
		_value = toUnsafePointer(value)
		self.count = count
		self.transpose = GLboolean(transpose ? GL_TRUE : GL_FALSE)
	}
	
	public func assign (location: GLuniformloc) {
		glUniformMatrix4dv(GLint(location.index), count, transpose, _value)
	}
}
