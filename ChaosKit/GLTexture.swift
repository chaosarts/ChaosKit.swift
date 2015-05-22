//
//  Texture.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 15.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL


public protocol GLTexture : GLIdentifiable, GLBindable {
	
	/// The texture target such as (GL_TEXTURE_1D)
	var target : GLenum {get}
	
	/// Sets a integer paramerter for this texture
	func setParameteri (pname: GLenum, _ param: GLint)
	
	/// Sets a float paramerter for this texture
	func setParameterf (pname: GLenum, _ param: GLfloat)
	
	/// Gets value of the passed texture parameter
	func iv (pname: Int32) -> GLint
}

/** 
Base class for texture objects
*/
public class GLTextureBase : GLBase {
	
	/// Contains the texture target like GL_TEXTURE_2D
	public let target : GLenum
	
	/// Provides the level of detail to use
	public let level : GLint
	
	/// Provides the internal format
	public let internalFormat : GLint
	
	public let border : GLint
	
	public let format : GLenum
	
	public let type : GLenum
	
	
	/** 
	Initializes the texture with passed target
	
	:param: target Texture target like GL_TEXTURE_2D
	*/
	internal init (_ target: Int32, _ level: Int, _ internalFormat: Int32, _ border: Int, _ format: Int32, _ type: Int32) {
		var textures : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenTextures(1, textures)
		
		self.target = GLenum(target)
		
		self.level = GLint(level)
		self.internalFormat = GLint(internalFormat)
		self.border = GLint(border)
		self.format = GLenum(format)
		self.type = GLenum(type)
		
		super.init(textures.memory)
	}
	
	
	/**
	Binds this texture
	*/
	public func bind () {
		glBindTexture(target, id)
	}
	
	
	/**
	Unbinds the current texture
	*/
	public func unbind() {
		glBindTexture(target, 0)
	}
	
	
	/** 
	Sets an paramter for the texture
	
	:param: pname The name of the parameter to set
	:param: param The parameter value
	*/
	public func setParameteri (pname: GLenum, _ param: GLint) {
		glTexParameteri(id, pname, param)
	}
	
	
	/**
	Sets an paramter for the texture
	
	:param: pname The name of the paramater
	:param: param The value of the parameter
	*/
	public func setParameterf (pname: GLenum, _ param: GLfloat) {
		glTexParameterf(id, pname, param)
	}
	
	/** 
	Specifies the index of the lowest defined mipmap level. This is an integer value. The initial value is 0.
	
	:param: value The value of the base level
	*/
	public func setBaseLevel (value: GLint) {
		setParameteri(GLenum(GL_TEXTURE_BASE_LEVEL), value)
	}
	
	
	public func setMinFilter (value: Int32) {
		setParameteri(GLenum(GL_TEXTURE_MIN_FILTER), value)
	}
	
	
	public func setMagFilter (value: Int32) {
		setParameteri(GLenum(GL_TEXTURE_MAG_FILTER), value)
	}
	
	
	public func setWrapS (value: Int32) {
		setParameteri(GLenum(GL_TEXTURE_WRAP_S), value)
	}
	
	
	/**
	Returns information about the current bound texture
 	*/
	public func iv (pname: Int32) -> GLint {
		var params : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		glGetTexParameteriv(target, GLenum(pname), params)
		return params.memory
	}
}

