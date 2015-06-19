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
	
	/// Contains the pixels of the texture
	var pixels : UnsafeMutablePointer<Void> {get}

	/**
	Sets an paramter for the texture
	
	:param: pname The name of the parameter to set
	:param: param The parameter value
	*/
	func setParameteri (pname: GLenum, _ param: GLint)
	
	
	/**
	Sets an paramter for the texture
	
	:param: pname The name of the parameter to set
	:param: param The parameter value
	*/
	func setParameterf (pname: GLenum, _ param: GLfloat)
	
	
	/**
	Returns information about the current bound texture
	
	:param: pname The paramater name
	:return: The value of the parameter
	*/
	func iv (pname: Int32) -> GLint
	
	
	/**
	Specifies the index of the lowest defined mipmap level. This is an integer value. The initial value is 0.
	
	:param: value The value of the base level
	*/
	func setBaseLevel (value: GLint)
	
	/**
	Specifies the filter for minifying
	
	:param: value
	*/
	func setMinFilter (value: Int32)
	
	
	/**
	Specifies the filter for magnifying
	
	:param: value
	*/
	func setMagFilter (value: Int32)
}

/** 
Base class for texture objects
*/
public class GLTextureBase {
	
	public var id : GLuint {get {return _ptr.memory}}
	
	/// Provides the pointer with which the texture has been created
	private var _ptr : UnsafeMutablePointer<GLuint>
	
	/// Contains the pixels of the texture
	internal var _pixels : UnsafeMutablePointer<Void>
	
	/// Contains the texture target like GL_TEXTURE_2D
	public let target : GLenum
	
	/// Provides the pixel of the texture
	public var pixels : UnsafeMutablePointer<Void> {get {return _pixels}}
	
	
	/**
	Initializes the texture with passed target
	
	:param: target Texture target like GL_TEXTURE_2D
	*/
	internal init (_ target: GLenum, pixels: UnsafeMutablePointer<Void>) {
		_pixels = pixels
		_ptr = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenTextures(1, _ptr)
		
		self.target = target
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
	
	
	/**
	Specifies the filter for minifying
	
	:param: value
	*/
	public func setMinFilter (value: Int32) {
		setParameteri(GLenum(GL_TEXTURE_MIN_FILTER), value)
	}
	
	
	/**
	Specifies the filter for minifying
	
	:param: value
	*/
	public func setMagFilter (value: Int32) {
		setParameteri(GLenum(GL_TEXTURE_MAG_FILTER), value)
	}
	
	
	/**
	Returns information about the current bound texture
	
	:param: pname The paramater name
	:return: The value of the parameter
 	*/
	public func iv (pname: Int32) -> GLint {
		var params : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		glGetTexParameteriv(target, GLenum(pname), params)
		return params.memory
	}
}

