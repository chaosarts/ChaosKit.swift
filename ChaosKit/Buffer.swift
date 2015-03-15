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
		
		var buffer : Buffer = Buffer(GL_ARRAY_BUFFER, blocks)
		
		// Buffer data
		var data : [GLfloat] = []
		
		for vertex in bufferable.vertice {
			for target in AttributeTarget.cases {
				data += vertex[target].array
			}
		}

		buffer.setData(data)
		
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
	
	/// Returns the default buffer strategy
	public class func defaultBufferStrategy () -> BufferStrategy {
		return DefaultBufferStrategy()
	}
	
	/// The target buffer like GL_ARRAY_BUFFER
	public let target: GLenum
	
	/// Contains a list of block information objects
	public let blocks : [AttributeTarget : BufferBlock]
	
	/// Contains the stride in bytes
	public let stride: GLsizeiptr
	
	/// Returns the size of the buffer in bytes
	public var size : GLint {get {return iv(GL_BUFFER_SIZE)}}
	
	/// Returns the usage of the buffer, like GL_STATIC_DRAW
	public var usage : GLenum = GLenum(GL_STATIC_DRAW)
	
	/**
	Initializes
	*/
	public init (_ target: Int32, _ blocks: [AttributeTarget : BufferBlock]) {
		var vbo : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenBuffers(1, vbo)
		
		var stride : Int = 0
		for type in blocks.keys {
			stride += Int(blocks[type]!.size)
		}
		
		self.target = GLenum(target)
		self.blocks = blocks
		self.stride = GLsizeiptr(stride * sizeof(GLfloat))
		
		super.init(id: vbo.memory)
	}
	
	
	/**
	Returns parameters of a buffer
	
	:param: pname The name of the parameter to retrieve
	*/
	public func iv (pname: Int32) -> GLint {
		if _ivCache[pname] == nil {updateIvCache(pnames: pname)}
		return _ivCache[pname]!
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
		glBindBuffer(target, 0)
	}
	
	
	public func setData (data: [GLfloat]) {
		bind()
		var pointer = toUnsafePointer(data)
		glBufferData(target, data.count * sizeof(GLfloat), UnsafePointer<Void>(pointer), usage)
		updateIvCache(pnames: GL_BUFFER_SIZE)
		unbind()
	}
	
	
	/**
	Determines if the buffer contains data for passed attribute target
	
	:param: target The attribute target to check
	:returns: True if there are values within the buffered data for passed target, otherwise false
	*/
	public func provides (target: AttributeTarget) -> Bool {
		return blocks[target] != nil
	}
	
	
	/**
	Updates the iv cache for passed parameter names
	*/
	private func updateIvCache (pnames names: Int32...) {
		for pname in names {
			var params : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
			glGetBufferParameteriv(target, GLenum(pname), params)
			_ivCache[pname] = params.memory
		}
	}
}