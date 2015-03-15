//
//  Buffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL


/*
|--------------------------------------------------------------------------
| Protocols for buffers
|--------------------------------------------------------------------------
*/

/** 
This protocol is used to mark a struct or class as bufferable so it can be 
passed to Buffer or BufferStrategy object
*/
public protocol Bufferable {
	var vertice : [Vertex] {get}
	
	var buffers : [Buffer] {get}
}

/**
Protocol for buffer strategy.
*/
public protocol BufferStrategy {
	/** 
	Method to buffer bufferable objects like the Shape class
	*/
	func buffer (bufferable: Bufferable) -> [Buffer]?
}


public class DefaultBufferStrategy : BufferStrategy {
	public func buffer (bufferable: Bufferable) -> [Buffer]? {
		if (bufferable.vertice.count == 0) {return nil}
		
		// Generate buffer
		var vbo: UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenBuffers(1, vbo);
		
		// Create buffer object
		var vertex : Vertex = bufferable.vertice.first!
		var blocks : [AttributeTarget : BufferBlock] = [AttributeTarget : BufferBlock]()
		var byteOffset : Int = 0
		
		for target in AttributeTarget.cases {
			var size : Int = vertex[target].array.count
			var block : BufferBlock = BufferBlock(size, target)
			block.byteOffset = byteOffset
			
			byteOffset += size
			blocks[target] = block
		}
		
		// Buffer data
		var buffer : Buffer = Buffer(vbo.memory, blocks, GLenum(GL_ARRAY_BUFFER), byteOffset)
		var data : [GLfloat] = []
		
		for vertex in bufferable.vertice {
			for target in AttributeTarget.cases {
				data += vertex[target].array
			}
		}
		
		buffer.bind()
		
		return [buffer]
	}
}

/*
|--------------------------------------------------------------------------
| Buffer Block Struct
|--------------------------------------------------------------------------
*/

/**
A buffer block is a part of a buffer batch, which is the element of a 
interleaved data buffer. It provides a set of information of a buffer batch, 
such as the size of an attribute per vertex or the type.
*/
public struct BufferBlock {
	
	/// Provides the value count of an attribute per vertex (1, 2 ,3 or 4)
	public let size : GLint
	
	/// This contains the byte offset of the first attribute data in the buffer
	public var byteOffset : Int = 0

	/// Provides the data type of the data for the shader program (e.g.
	/// GL_FLOAT, GL_DOUBLE)
	public var type : GLenum = GLenum(GL_FLOAT)
	
	/// Indicates if the data shall be normalized or not (GL_TRUE or GL_FALSE)
	public var normalize : GLboolean = GLboolean(GL_FALSE)
	
	/// Provides which vertex attribute to target
	public var target : AttributeTarget
	
	
	/** 
	Initializes the block info object with size, normalize flag and data type 
	
	:param: size The size of an attribute per vertex
	*/
	public init (_ size: Int, _ target: AttributeTarget) {
		self.size = GLint(size)
		self.target = target
	}
}


/*
|--------------------------------------------------------------------------
| Protocol for Buffer Delegate
|--------------------------------------------------------------------------
*/

/**
This protocols describes a delegate for a buffer
*/
public final class Buffer : OpenGLBase {
		
	/// Contains a list of block information objects
	public let blocks : [AttributeTarget : BufferBlock]
	
	/// The target buffer like GL_ARRAY_BUFFER
	public let target: GLenum
	
	/// Contains the stride
	public let stride: Int
	
	/// Returns the size of the buffer in bytes
	public var size : GLint {get {return iv(GL_BUFFER_SIZE)}}
	
	/// Returns the usage of the buffer, like GL_STATIC_DRAW
	public var usage : GLint {get {return iv(GL_BUFFER_USAGE)}}
	
	/**
	Initializes
	*/
	public init (_ id: GLuint, _ blocks: [AttributeTarget : BufferBlock], _ target: GLenum, _ stride: Int) {
		self.blocks = blocks
		self.target = target
		self.stride = stride
		super.init(id: id)
	}
	
	
	public func setData (data: [GLfloat]) {
		bind()
		var ptr : UnsafePointer<Void> = UnsafePointer<Void>(toUnsafePointer(data))
		glBufferData(target, sizeof(GLfloat) * data.count, ptr, GLenum(usage))
		unbind()
	}
	
	
	/** 
	Binds the buffer
	*/
	public func bind () {
		glBindBuffer(target, id)
	}
	
	
	/**
	Unbinds the buffer
	*/
	public func unbind () {
		glBindBuffer(target, id)
	}
	
	
	/**
	Returns parameters of a buffer
	
	:param: pname The name of the parameter to retrieve
 	*/
	public func iv (pname: Int32) -> GLint {
		if _ivCache[pname] == nil {
			var params : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
			glGetBufferParameteriv(target, GLenum(pname), params)
			_ivCache[pname] = params.memory
		}
		
		return _ivCache[pname]!
	}
}