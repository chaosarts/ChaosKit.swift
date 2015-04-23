//
//  GLVertexBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLVertexBuffer {
	
	public let ptr : UnsafeMutablePointer<GLuint>
	
	public let blocks : [GLBufferBlock]
	
	public let stride : GLint
	
	public var usage : GLenum
	
	public init (blocks: [GLBufferBlock]) {
		
		var stride : GLint = 0
		var blocks : [GLBufferBlock] = []
		
		for i in 0..<blocks.count {
			var block : GLBufferBlock = blocks[i]
			block.offset = stride
			stride += block.size
			blocks.append(block)
		}
		
		
		var buffer : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenBuffers(1, buffer)
		
		self.ptr = buffer
		self.stride = stride
		self.blocks = blocks
		self.usage = blocks.count > 1 ? GLenum(GL_STATIC_DRAW) : GLenum(GL_DYNAMIC_DRAW)
	}
	
	
	public func buffer (vertice: [GLVertex]) {
		var data : [GLfloat] = []
		for vertex in vertice {
			for block in blocks {
				data += vertex[block.attribute]!.array
			}
		}
	}
}