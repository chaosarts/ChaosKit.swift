//
//  GLBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


/**
*/
public class GLShapeBuffer {
	
	/*
	|--------------------------------------------------------------------------
	| Stored properties
	|--------------------------------------------------------------------------
	*/
	
	/// Provides a list of buffer objects, which are to use when configuring this vertex array
	private var _buffers : [GLBuffer] = []
	
	/// Provides the count of vertice, this buffer provides
	private var _count : Int = 0
	
	/// Provides the target
	public var target : GLBufferTarget = GLArrayBufferTarget()
	
	/// Provides the draw mode
	public var mode : GLenum = GLenum(GL_TRIANGLES)
	
	
	/*
	|--------------------------------------------------------------------------
	| Derived properties
	|--------------------------------------------------------------------------
	*/
	
	/// Provides a list of buffer objects, which are to use when configuring this vertex array
	public var buffers : [GLBuffer] { get {return _buffers}}
	
	/// Provides the count of vertice, this buffer provides
	public var count : Int {get {return _count}}
	
	
	/*
	|--------------------------------------------------------------------------
	| Intializers
	|--------------------------------------------------------------------------
	*/
	
	/**
	Initializes the vertex array with given target
	
	:param: target The buffer target (GL_ARRAY_BUFFER, GL_ARRAY_ELEMENT_BUFFER)
	*/
	public init (target: GLBufferTarget) {
		self.target = target
	}
	
	
	/*
	|--------------------------------------------------------------------------
	| Methods
	|--------------------------------------------------------------------------
	*/
	
	
	public func buffer (shape: GLShape) {
		var bufferables : [GLLocationSelector : GLBufferable] = shape.bufferables
		
		_configure(bufferables)
		for buffer in buffers {
			var data : [GLfloat] = []
			
			for index in 0..<shape.geometry.count {
				for block in buffer.blocks {
					var bufferable : GLBufferable = bufferables[block.selector]!
					data += bufferable[index]
				}
			}
			
			buffer.bind()
			buffer.buffer(data)
		}
	}
	
	
	private func _configure (bufferables: [GLLocationSelector : GLBufferable]) {
		
		// Group by dynmaic and static attributes
		// **************************************
		
		// Store static bufferables in this array to configure static buffer later
		var staticBufferables : [GLLocationSelector : GLBufferable] = [GLLocationSelector : GLBufferable]()
		
		// Store the stride
		var stride : Int = 0
		
		// Configure dynamic buffers and preconfigure static buffer
		for selector in bufferables.keys {
			
			var bufferable : GLBufferable = bufferables[selector]!
			
			if bufferable.count == 0 {continue}
			
			// Handle only non-dynmaic buffers
			if bufferable.dynamic {
				/// Creates one buffer per dynamic
				var block : GLBufferBlock = GLBufferBlock(selector, bufferable.size, GL_FLOAT, true, 0, 0)
				var buffer : GLBuffer = GLBuffer(target: target.value, usage: GLenum(GL_DYNAMIC_DRAW), blocks: [block])
				_buffers.append(buffer)
				continue
			}
			
			// Append buffer to static group
			staticBufferables[selector] = bufferable
			
			// Increase stride with new appended static attribute
			stride += bufferable.size
		}
		
		
		// Configure the static buffer
		var offset : Int = 0
		var blocks : [GLBufferBlock] = []
		for selector in staticBufferables.keys {
			var bufferable : GLBufferable = bufferables[selector]!
			var block : GLBufferBlock = GLBufferBlock(selector, bufferable.size, GL_FLOAT, true, stride, offset)
			blocks.append(block)
			offset += Int(block.size)
		}
		
		_buffers.append(GLBuffer(target: target.value, usage: GLenum(GL_STATIC_DRAW), blocks: blocks))
	}
}