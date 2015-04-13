//
//  GLTexture2D.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLTexture2D : GLTextureBase, GLTexture {
	
	public init (_ level: Int, _ internalFormat: Int32, _ width: Int, _ height: Int, _ border: Int, _ format: Int32, _ type: Int32, _ pixels: UnsafePointer<Void>) {
		super.init(target: GL_TEXTURE_2D)
		
		bind()
		glTexImage2D(id, 0, GLint(internalFormat), GLsizei(width), GLsizei(height), 0, GLenum(format), GLenum(type), pixels)
		unbind()
	}
	
	
	public convenience init () {
		self.init(0, GL_RGBA, 1024, 1024, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil)
	}
}