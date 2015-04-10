//
//  GLTexture1D.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLTexture1D : GLTexture {
	
	public var level : GLint
	
	public var internalFormat : GLint
	
	public var width : GLsizei
	
	public var border : GLint
	
	public var format : GLenum
	
	public var type : GLenum
	
	public var pixels : UnsafePointer<Void>
	
	public init (_ level: Int, _ internalFormat: Int32, _ width: Int, _ border: Int, _ format: Int32, _ type: Int32, _ pixels: UnsafePointer<Void>) {
		
		self.level = GLint(level)
		self.internalFormat = GLint(internalFormat)
		self.width = GLsizei(width)
		self.border = GLint(border)
		self.format = GLenum(format)
		self.type = GLenum(type)
		self.pixels = pixels
		
		super.init(target: GL_TEXTURE_1D)
	}
	
	public convenience init () {
		self.init(0, GL_RGBA, 512, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil)
	}
	
	public func create () {
		glTexImage1D(target, level, internalFormat, width, border, format, type, pixels)
	}
}