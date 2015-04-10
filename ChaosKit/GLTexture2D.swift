//
//  GLTexture2D.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLTexture2D : GLTexture {
	
	public var level : GLint
	
	public var internalFormat : GLint
	
	public var width : GLsizei
	
	public var height : GLsizei
	
	public var border : GLint
	
	public var format : GLenum
	
	public var type : GLenum
	
	public var pixels : UnsafePointer<Void>
	
	public init (_ level: Int, _ internalFormat: Int32, _ width: Int, _ height: Int, _ border: Int, _ format: Int32, _ type: Int32, _ pixels: UnsafePointer<Void>) {
		
		self.level = GLint(level)
		self.internalFormat = GLint(internalFormat)
		self.width = GLsizei(width)
		self.height = GLsizei(height)
		self.border = GLint(border)
		self.format = GLenum(format)
		self.type = GLenum(type)
		self.pixels = pixels
		
		super.init(target: GL_TEXTURE_2D)
	}
	
	
	public convenience init () {
		self.init (0, GL_RGBA, 1024, 1024, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil)
	}
	
	
	public func create () {
		glTexImage2D(id, 0, GLint(internalFormat), GLsizei(width), GLsizei(height), 0, GLenum(format), GLenum(type), pixels)
	}
}