//
//  GLBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLVertexBuffer {
	
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
}

/**
*/
public class GLVertexBufferBase {
	
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
}