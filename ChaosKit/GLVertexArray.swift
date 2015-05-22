//
//  GLVertexArray.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 03.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLVertexArray : GLBase {
	
	private var _ptr : UnsafeMutablePointer<GLuint>
	
	public let vertexBuffer : GLVertexBuffer
	
	public let program : GLProgram
	
	public init (program: GLProgram, vertexBuffer: GLVertexBuffer) {
		self.vertexBuffer = vertexBuffer
		self.program = program
		
		_ptr = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenVertexArrays(1, _ptr)
		
		super.init(_ptr.memory)
	}
	
	
	public func configure () {
		bind()
		
		for buffer in vertexBuffer.buffers {
			if buffer.blocks.count > 1 {
				configureStatic(buffer)
			}
			else {
				
			}
		}
		
		unbind()
	}
	
	
	public func bind () {
		glBindVertexArray(id)
	}
	
	
	public func unbind () {
		glBindVertexArray(0)
	}
	
	
	private func configureStatic (buffer: GLBuffer) {
		var blocks : [GLBufferBlock] = []
		for block in buffer.blocks {
			var attribute : GLAttribLocation? = program.getAttribLocation(block.attribute)
			
			if attribute == nil {continue}
			
			var pointer : UnsafeMutablePointer<Void> = attribute!.getVertexAttribPointer()
			attribute!.enable()
			attribute!.setVertexAttribPointer(block)
		}
	}
}