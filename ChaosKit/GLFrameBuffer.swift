//
//  GLFrameBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 04.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

public protocol GLFrameBuffer {
	var id : GLuint {get}
	
	var ptr : UnsafeMutablePointer<GLuint> {get}
	
	var texture : GLTexture {get}
	
	func texture (attachment: Int32, level: Int)
}

public class GLFrameBufferBase : GLBase {
	
	private var _ptr : UnsafeMutablePointer<GLuint>
	
	public var ptr : UnsafeMutablePointer<GLuint> {get {return _ptr}}
	
	public var texture : GLTexture
	
	public let target : GLenum = GLenum(GL_FRAMEBUFFER)
	
	
	public init (texture: GLTexture) {
		self.texture = texture
		
		_ptr = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenFramebuffers(1, _ptr)
		super.init(_ptr.memory)
	}
	
	
	public func bind () {
		glBindFramebuffer(target, id)
		texture.bind()
	}
	
	
	public func unbind () {
		glBindFramebuffer(target, id)
		texture.unbind()
	}
}


public class GLFrameBufferTexture1D : GLFrameBufferBase, GLFrameBuffer {
	public func texture (attachment: Int32, level: Int) {
		//glFramebufferTexture1D(target, GLenum(attachment), texture.target, texture.id, GLint(level))
	}
}

public class GLFrameBufferTexture2D : GLFrameBufferBase, GLFrameBuffer {
	public func texture (attachment: Int32, level: Int) {
		//glFramebufferTexture2D(target, GLenum(attachment), texture.target, texture.id, GLint(level))
	}
}
