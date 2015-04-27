//
//  GLVertexArray.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 21.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GLVertexArray : GLBase, GLBindable {
	
	public let ptr : UnsafeMutablePointer<GLuint>
	
	public init () {
		var vao : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenVertexArrays(1, vao)
		ptr = vao
		
		super.init(id: ptr.memory)
	}
	
	
	public func attribPointer (index: GLuint, block: GLBufferBlock) {
		var pointer : UnsafeMutablePointer<UnsafeMutablePointer<Void>> = UnsafeMutablePointer<UnsafeMutablePointer<Void>>.alloc(1)
		glGetVertexAttribPointerv(index, GLenum(GL_VERTEX_ATTRIB_ARRAY_POINTER), pointer)
		glVertexAttribPointer(index, block.size, GLenum(GL_FLOAT), GLboolean(GL_TRUE), block.stride, pointer.memory)
	}
	
	
	public func bind () {
		glBindVertexArray(id)
	}
	
	
	public func unbind() {
		glBindVertexArray(0)
	}
}