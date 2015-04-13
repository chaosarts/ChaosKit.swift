//
//  GLTexture1D.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLTexture1D : GLTextureBase, GLTexture {

	
	public init (_ level: Int, _ internalFormat: Int32, _ width: Int, _ border: Int, _ format: Int32, _ type: Int32, _ pixels: UnsafePointer<Void>) {
		
		super.init(GL_TEXTURE_1D, level, internalFormat, border, format, type)
		
		bind()
		glTexImage1D(GLenum(target), GLint(level), GLint(internalFormat), GLsizei(width), GLint(border), GLenum(format), GLenum(type), pixels)
		unbind()
	}
	
	public convenience init () {
		self.init(0, GL_RGBA, 512, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil)
	}
}