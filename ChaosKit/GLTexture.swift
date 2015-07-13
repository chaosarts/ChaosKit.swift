//
//  Texture.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 15.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

/** 
Base class for texture objects
*/
public class GLTexture {
	
	/// Provides the pointer with which the texture has been created
	private var _ptr : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
	
	/// Caches the pixel data if requested
	public var _pixels : UnsafeMutablePointer<Void> = nil
	
	/// Contains the texture target like GL_TEXTURE_2D
	public var target : GLenum
	
	/// Inidcates the format of the pixel data
	public var format : GLenum = GLenum(GL_RGBA)
	
	/// Indicates the data type of a pixel component
	public var type : GLenum = GLenum(GL_UNSIGNED_BYTE)
	
	/// Indicates the internal pixel format of the texture
	public var internalFormat : GLint = GLint(GL_RGB)
	
	/// Indicates the level of detail to use of the mipmap filtering
	public var level : GLint = 0
	
	/// Provides the texture name genereated with glGenTexture()
	public var id : GLuint {get {return _ptr.memory}}
	
	/// Shortcut to set pixel storage mode for pack alignment
	public var packAlignment : GLint {
		get {return GL.getIntegerv(GL_PACK_ALIGNMENT)}
		set {setPixelStorei(GLenum(GL_PACK_ALIGNMENT), newValue)}
	}
	
	/// Shortcut to set pixel storage mode for unpack alignment
	public var unpackAlignment : GLint {
		get {return GL.getIntegerv(GL_UNPACK_ALIGNMENT)}
		set {setPixelStorei(GLenum(GL_UNPACK_ALIGNMENT), newValue)}
	}
	
	public var magFilter : GLint {
		get {return GL.getIntegerv(GL_TEXTURE_MAG_FILTER)}
		set {setParameteri(GLenum(GL_TEXTURE_MAG_FILTER), newValue)}
	}
	
	
	public var minFilter : GLint {
		get {return GL.getIntegerv(GL_TEXTURE_MIN_FILTER)}
		set {setParameteri(GLenum(GL_TEXTURE_MIN_FILTER), newValue)}
	}
	
	/// Provides the wrap mode for s parameter
	public var wrapS : GLint {
		get {return GL.getIntegerv(GL_TEXTURE_WRAP_S)}
		set {setParameteri(GLenum(GL_TEXTURE_WRAP_S), newValue)}
	}
	
	/// Provides the wrap mode for t parameter
	public var wrapT : GLint {
		get {return GL.getIntegerv(GL_TEXTURE_WRAP_T)}
		set {setParameteri(GLenum(GL_TEXTURE_WRAP_T), newValue)}
	}
	
	/// Provides the wrap mode for s parameter
	public var wrapR : GLint {
		get {return GL.getIntegerv(GL_TEXTURE_WRAP_R)}
		set {setParameteri(GLenum(GL_TEXTURE_WRAP_R), newValue)}
	}
	
	/**
	Initializes the texture with passed target
	
	:param: target Texture target like GL_TEXTURE_2D
	*/
	internal init (_ target: GLenum) {
		self.target = target
		glGenTextures(1, _ptr)
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
	Returns texture parameter values
	
	:param: params
	:return: The value of the texture paramater
	*/
	public func getParameteri (pname: GLenum) -> GLint {
		var params : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		glGetTexParameteriv(target, pname, params)
		
		var mem : GLint = params.memory
		params.destroy()
		params.dealloc(1)
		
		return mem
	}
	
	
	/**
	Returns texture parameter values
	
	:param: params
	:return: The value of the texture paramater
	*/
	public func getParameterf (pname: GLenum) -> GLfloat {
		var params : UnsafeMutablePointer<GLfloat> = UnsafeMutablePointer<GLfloat>.alloc(1)
		glGetTexParameterfv(target, pname, params)
		
		var mem : GLfloat = params.memory
		params.destroy()
		params.dealloc(1)
		
		return mem
	}
	
	
	/** 
	Sets an paramter for the texture
	
	:param: pname The name of the parameter to set
	:param: param The parameter value
	*/
	public func setParameteri (pname: GLenum, _ param: GLint) {
		glTexParameteri(target, pname, param)
	}
	
	
	/**
	Sets an paramter for the texture
	
	:param: pname The name of the paramater
	:param: param The value of the parameter
	*/
	public func setParameterf (pname: GLenum, _ param: GLfloat) {
		glTexParameterf(target, pname, param)
	}
	
	
	/**
	Sets pixel storage modes
	
	:param: pname Specifies the symbolic name of the parameter to be set. GL_PACK_ALIGNMENT affects the packing of pixel data into memory. GL_UNPACK_ALIGNMENT affects the unpacking of pixel data from memory.
	:param: param Specifies the value that pname is set to.
	*/
	public func setPixelStorei (pname: GLenum, _ param: GLint) {
		glPixelStorei(pname, param)
	}
	
	
	/**
	Sets pixel storage modes
	
	:param: pname Specifies the symbolic name of the parameter to be set. GL_PACK_ALIGNMENT affects the packing of pixel data into memory. GL_UNPACK_ALIGNMENT affects the unpacking of pixel data from memory.
	:param: param Specifies the value that pname is set to.
	*/
	public func setPixelStoref (pname: GLenum, _ param: GLfloat) {
		glPixelStoref(pname, param)
	}
	
	
	/**
	Returns information about the current bound texture
	
	:param: pname The paramater name
	:return: The value of the parameter
 	*/
	public func iv (pname: Int32) -> GLint {
		var params : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		glGetTexParameteriv(target, GLenum(pname), params)
		
		var mem : GLint = params.memory
		params.destroy()
		params.dealloc(1)
		return mem
	}
	
	
	/**
	Deinitializes the texture
	*/
	deinit {
		glDeleteTextures(1, _ptr)
		_ptr.destroy()
		_ptr.dealloc(1)
	}
}

