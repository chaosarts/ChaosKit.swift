//
//  GLVertexArray.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 06.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLVertexArray : GLBase {
	
	let ptr : UnsafeMutablePointer<GLuint>
	
	let buffer : GLBuffer
	
	public init (buffer: GLBuffer) {
		var vao : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenVertexArrays(1, vao)
		ptr = vao
		
		self.buffer = buffer
		
		super.init(id: vao.memory)
	}
	
	
	public func bind () {
		glBindVertexArray(id)
	}
	
	
	public func unbind () {
		glBindVertexArray(0)
	}
}