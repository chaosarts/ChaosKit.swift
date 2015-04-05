//
//  GLFrameBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 04.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GLFrameBuffer : GLBase {
	
	private var _ptr : UnsafeMutablePointer<GLuint>
	
	public var ptr : UnsafeMutablePointer<GLuint> {get {return _ptr}}
	
	public init () {
		_ptr = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenFramebuffers(1, _ptr)
		
		super.init(id: _ptr.memory)
	}
	
	
	public func bind () {
		glBindFramebuffer(GLenum(GL_FRAMEBUFFER), id)
	}
	
	
	public func unbind () {
		glBindFramebuffer(GLenum(GL_FRAMEBUFFER), id)
	}
}
