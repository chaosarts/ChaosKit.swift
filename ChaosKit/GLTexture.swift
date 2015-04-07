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
public class GLTexture : GLBase {
	
	/// Contains the texture target like GL_TEXTURE_2D
	public let target : GLenum
	
	
	/** 
	Initializes the texture with passed target
	
	:param: target Texture target like GL_TEXTURE_2D
	*/
	private init (target: Int32) {
		var textures : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenTextures(1, textures)
		
		self.target = GLenum(target)
		super.init(id: textures.memory)
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
	
	
	public func parameteri (pname: Int32, _ param: Int32) {
		glTexParameteri(id, GLenum(pname), GLint(param))
	}
	
	public func parameterf (pname: Int32, _ param: GLfloat) {
		glTexParameterf(id, GLenum(pname), param)
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


public class GLTexture1D : GLTexture {
	
	private var _width : Int
	
	public var width : Int {get {return _width}}
	
	public init (_ width: Int) {
		_width = width
		super.init (target: GL_TEXTURE_1D)
	}
}



public class GLTexture2D : GLTexture {
	
	public let size : Sizei
	
	public var width : Int {get {return size.width}}
	
	public var height : Int {get {return size.height}}
	
	
	public init (_ size: Sizei) {
		self.size = size
		super.init (target: GL_TEXTURE_2D)
	}
	
	
	public func create (internalFormat: Int32, _ format: Int32, _ type: Int32, _ pointer: UnsafePointer<Void>) {
		glTexImage2D(id, 0, GLint(internalFormat), GLsizei(width), GLsizei(height), 0, GLenum(format), GLenum(type), pointer)
	}
}