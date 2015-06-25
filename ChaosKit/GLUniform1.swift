//
//  GLUniform1.swift
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

public struct GLUniform1d : GLUniform, FloatLiteralConvertible {
	
	private let _value : GLdouble
	
	public init (_ value: GLdouble) {
		_value = value
	}
	
	public init (floatLiteral value: GLdouble) {
		self.init(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1d(GLint(location.id), _value)
	}
}


public struct GLUniform1f : GLUniform, FloatLiteralConvertible {
	
	private let _value : GLfloat
	
	public init (_ value: GLfloat) {
		_value = value
	}
	
	public init (floatLiteral value: GLfloat) {
		self.init(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1f(GLint(location.id), _value)
	}
}


public struct GLUniform1i : GLUniform, IntegerLiteralConvertible {
	
	private let _value : GLint
	
	public init (_ value: GLint) {
		_value = value
	}
	
	public init (integerLiteral value: GLint) {
		self.init(value)
	}
	
	public func assign (location: GLUniformLocation) {
		glUniform1i(GLint(location.id), _value)
	}
}


public struct GLUniform1ui : GLUniform, IntegerLiteralConvertible {
	
	private let _value : GLuint
	
	
	public init (_ value: GLuint) {
		_value = value
	}
	
	public init (integerLiteral value: GLuint) {
		self.init(value)
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


/*
|--------------------------------------------------------------------------
| Texture
|--------------------------------------------------------------------------
*/

public struct GLUniformTexture : GLUniform {
	private let _texture : GLTexture
	
	private let _index: Int
	
	public init (_ texture: GLTexture, _ index: Int) {
		_texture = texture
		_index = index
	}
	
	
	public func assign (location: GLUniformLocation) {
		let index : GLenum = GLenum(GL_TEXTURE0 + Int32(_index))
		glActiveTexture(index)
		_texture.bind()
		glUniform1i(GLint(location.id), GLint(_index))
	}
}