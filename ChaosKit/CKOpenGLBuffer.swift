//
//  CKOpenGLBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

/*
|--------------------------------------------------------------------------
| Protocol for Bufferable Object
|--------------------------------------------------------------------------
*/

/** 
This protocol is used to mark a struct or class as bufferable
so it can be passed to buffer object
*/
public protocol CKOpenGLBufferable {
	
	/** Contains information about a buffer block */
	var size : Int {get}
	
	/** Provides the count of vertices a bufferable serves with its data */
	var count : Int {get}
	
	/** Contains the data to buffer as array of float*/
	var array : [GLfloat] {get}
	
	/** Shortcut subscript to access single data set of one vertex */
	subscript (index: Int) -> [GLfloat] {get}
}


/*
|--------------------------------------------------------------------------
| Buffer Block Struct
|--------------------------------------------------------------------------
*/

/**
A buffer block is a part of a buffer batch, which is the element of a interleaved data buffer.
It provides a set of information of a buffer batch, such as the size of an attribute per vertex,
the type
*/
public struct CKOpenGLBufferBlock {
	
	/** The generated name of the buffer this block belongs to. This is one of the
 	memories within a UnsafeMutablePointer you initialize with glGenBuffers() */
	public let name : GLuint
	
	/** Provides the value count of an attribute per vertex (1, 2 ,3 or 4) */
	public let size : GLint
	
	/** Provides the data type of the data for the shader program (e.g. GL_FLOAT, GL_DOUBLE)*/
	public let type : GLenum
	
	/** Indicates if the data shall be normalized or not (GL_TRUE or GL_FALSE)*/
	public let normalize : GLboolean
	
	/** This contains the byte offset of the first attribute data in the buffer */
	public let byteOffset : Int
	
	/** 
	Initializes the block info object with size, normalize flag and data type 
	
	:param: size The size of an attribute per vertex 
	:param: normalize Indicates if the data shall be normalized
	:param: type The data type that shall be used within the shader program
	*/
	public init (_ name: GLuint, _ size: Int, _ byteOffset: Int, _ type: Int32 = GL_FLOAT, _ normalize: Int32 = GL_TRUE) {
		(self.name, self.size, self.byteOffset, self.type, self.normalize) =
			(name, GLint(size), byteOffset, GLenum(type), GLboolean(normalize))
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
public protocol CKOpenGLBufferStrategy {
	
	/** Contains a list of block information objects */
	var blocks : [CKOpenGLAttributeType : CKOpenGLBufferBlock] {get}
	
	/** Buffers the data and returns buffer data object */
	mutating func buffer (data: [CKOpenGLAttributeType : CKOpenGLBufferable])
}


/*
|--------------------------------------------------------------------------
| Buffer Class
|--------------------------------------------------------------------------
*/

/** 
Class to buffer vertex attribute data
*/
public class CKOpenGLBuffer {
	
	/** The buffer delegate */
	public var delegate : CKOpenGLBufferStrategy
	
	/** */
	public var blocks : [CKOpenGLAttributeType : CKOpenGLBufferBlock] {get {return delegate.blocks}}
	
	
	/**
	*/
	public class func defaultDelegate () -> CKOpenGLBufferStrategy {
		return CKOpenGLDefaultBufferStrategy()
	}
	
	
	/** 
	Initializes the buffer with an delegate 
	
	:param: delegate The buffer delegate containing the implementation how to buffer data
	*/
	public init () {
		delegate = CKOpenGLBuffer.defaultDelegate ()
	}
	
	
	/** 
	Buffers the data 
	
	:param: data The data to buffer
	*/
	public final func buffer (data d: [CKOpenGLAttributeType : CKOpenGLBufferable]) {
		delegate.buffer(d)
	}
}


/*
|--------------------------------------------------------------------------
| Default Buffer Delegate
|--------------------------------------------------------------------------
*/
internal struct CKOpenGLDefaultBufferStrategy : CKOpenGLBufferStrategy {
	var blocks : [CKOpenGLAttributeType : CKOpenGLBufferBlock] = [CKOpenGLAttributeType : CKOpenGLBufferBlock]()
	
	let ptr : UnsafePointer<GLuint>
	
	let size : Int
	
	var target : GLenum = GLenum(GL_ARRAY_BUFFER)
	
	var usage : GLenum = GLenum(GL_STATIC_DRAW)
	
	
	init () {
		size = 1
		var buffers : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(size)
		glGenBuffers(GLsizei(size), buffers)
		ptr = UnsafePointer<GLuint>(buffers)
	}
	
	mutating func buffer (datamap: [CKOpenGLAttributeType : CKOpenGLBufferable]) {
		glBindBuffer(target, ptr.memory)
		
		var count : Int = 0
		
		var byteOffset : Int = 0
		
		for type in datamap.keys {
			blocks[type] = CKOpenGLBufferBlock(ptr.memory, datamap[type]!.size, byteOffset)
			count = max(datamap[type]!.count, count)
			byteOffset = Int(blocks[type]!.size) * sizeof(GLfloat)
		}
		
		var array : [GLfloat] = []
		for i in 0..<count {
			for type in datamap.keys {
				array = array + datamap[type]![i]
			}
		}
		
		var data : UnsafePointer<Void> = UnsafePointer<Void>(toUnsafePointer(array))
		
		glBufferData(target, sizeof(GLfloat) * count, data, usage)
	}
}