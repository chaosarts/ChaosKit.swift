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
	var target : GLenum {get}
}

/** 
Base class for texture objects
*/
public class GLTextureBase : GLBase {
	
	/// Contains the texture target like GL_TEXTURE_2D
	public let target : GLenum
	
	public let level : GLint
	
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
	
	
	public func active () {
		
	}
	
	
	/** 
	Sets an paramter for the texture
	*/
	public func parameteri (pname: Int32, _ param: Int32) {
		glTexParameteri(id, GLenum(pname), GLint(param))
	}
	
	
	/**
	Sets an paramter for the texture
	*/
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

