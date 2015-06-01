//
//  GLBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLShapeBuffer {
	
	/// Provides the buffer target such as GL_ARRAY_BUFFER
	var target : GLenum {get}
	
	/// Provides the draw modes
	var mode : GLenum {get set}
	
	/// Provides a list of buffers of one shape
	var buffers : [GLBuffer] {get set}
	
	/// Countains the count of vertices
	var count : Int {get}
	
	/**
	Draws the buffer with given program
	*/
	func draw ()
	
	/**
	Buffers the shape
	
	:param: shape The shape to buffer
	*/
	func buffer (shape: GLShape)
	
	func setup (attributes: [GLAttribAlias : GLAttribute])
}

/**
*/
public class GLShapeBufferBase {
	
	/*
	|--------------------------------------------------------------------------
	| Stored properties
	|--------------------------------------------------------------------------
	*/
	
	/// Provides the count of vertice, this buffer provides
	private var _count : Int = 0
	
	/// Provides the target
	public let target : GLenum
	
	/// Provides the draw mode
	public var mode : GLenum = GLenum(GL_TRIANGLES)
	
	
	/*
	|--------------------------------------------------------------------------
	| Derived properties
	|--------------------------------------------------------------------------
	*/
	
	/// Provides a list of buffer objects, which are to use when configuring this vertex array
	public var buffers : [GLBuffer] = []
	
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
	internal init (target: Int32) {
		self.target = GLenum(target)
	}
	
	
	/*
	|--------------------------------------------------------------------------
	| Derived properties
	|--------------------------------------------------------------------------
	*/
	
	/**
	Buffers a shape
	*/
	public func buffer (shape: GLShape) {
		for buffer in buffers {
			buffer.bind()
			var data : [GLfloat] = []
			for index in 0..<shape.count {
				for block in buffer.blocks {
					data += shape[block.attribute, index]
				}
			}
			buffer.buffer(data)
		}
		
		_count = shape.count
	}
	
	
	public func setup (attributes: [GLAttribAlias : GLAttribute]) {
		// Group by dynmaic and static attributes
		// **************************************
		
		// Assign all attribute values to dynamic group and filter one by one to static
		var dynamicAttributes : [GLAttribAlias : GLAttribute] = attributes
		var staticAttributes : [GLAttribAlias : GLAttribute] = [GLAttribAlias : GLAttribute]()
		
		// Memorize the stride for static attributes
		var stride : Int = 0
		
		// This loop iterates through the dynamic attribute group, configures
		// the buffers and moves the static attributes to a separate group
		for key in dynamicAttributes.keys {
			var attribute : GLAttribute = dynamicAttributes[key]!
			
			// Handle only non-dynmaic buffers
			if attribute.dynamic {
				/// Creates one buffer per dynamic
				var block : GLBufferBlock = GLBufferBlock(key, attribute.size, GL_FLOAT, true, 0, 0)
				var buffer : GLBuffer = GLBuffer(target: target, usage: GLenum(GL_DYNAMIC_DRAW), blocks: [block])
				buffers.append(buffer)
				continue
			}
			
			// Do not add empty attributes
			if attribute.count == 0 {continue}
			
			// Append attribute to static group and remove it from dynamic
			staticAttributes[key] = attribute
			dynamicAttributes.removeValueForKey(key)
			
			// Increase stride with new appended static attribute
			stride += attribute.size
		}
		
		// Configure the static buffer
		var offset : Int = 0
		var sBlocks : [GLBufferBlock] = []
		for key in staticAttributes.keys {
			var attribute : GLAttribute = staticAttributes[key]!
			var block : GLBufferBlock = GLBufferBlock(key, attribute.size, GL_FLOAT, true, stride, offset)
			sBlocks.append(block)
			offset += Int(block.size)
		}
		
		buffers.append(GLBuffer(target: target, usage: GLenum(GL_STATIC_DRAW), blocks: sBlocks))
	}
}