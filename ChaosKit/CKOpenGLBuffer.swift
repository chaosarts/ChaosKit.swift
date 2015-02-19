//
//  CKOpenGLBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol CKOpenGLBuffer {
	var target : GLenum {get}
}


/**
Struct to summerize data for an array buffer
*/
public struct CKOpenGLArrayBufferData<T> : CKOpenGLBuffer {
	
	/** Pointer that points to the datas address.
	This is not the buffer pointer */
	public let ptr : UnsafePointer<Void>
	
	/** Provides the target, such as GL_ARRAY_BUFFER */
	public let target : GLenum = GLenum(GL_ARRAY_BUFFER)
	
	/** Provides the usage of the buffer data, such as GL_STATIC_DRAW */
	public let usage : GLenum
	
	/** Provides the size of the data in bytes */
	public let size : Int
	
	/** */
	public var typesize : Int {
		get {return sizeof(T)}
	}
	
	public init (data d: [T], usage u: Int32 = GL_STATIC_DRAW) {
		ptr = UnsafePointer<Void>(toUnsafePointer(d))
		usage = GLenum(u)
		size = sizeof(T) * d.count
	}
}


/**
Data struct that summerizes information for buffer data it's pointer etc
*/
public struct CKOpenGLArrayBuffer {
	
	/** Provides the count of buffers that has been generated */
	public let count : Int
	
	/** Provides the buffer pointers */
	public let ptr : UnsafeMutablePointer<GLuint>
	
	/** Initializes the buffer with passed count of buffers to generate */
	public init (num: Int) {
		count = num
		
		var pointer : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(count)
		glGenBuffers(GLsizei(count), pointer)
		
		ptr = pointer
	}
	
	
	/** 
	Buffers data for pointer at passed index
	
	:param: index The index of the pointer
	:param: data The buffer data object that contains the pointer to the data to buffer
	*/
	public func buffer<T> (index i: Int, data d: CKOpenGLArrayBufferData<T>) {
		let buffer : UnsafeMutablePointer<GLuint> = ptr.advancedBy(i)
		bindPointerAt(index: i)
		glBufferData(d.target, d.size, d.ptr, d.usage)
	}
	
	
	public func bindPointerAt (index i: Int) {
		assert(i > 0 && i < count, "Bad index access for buffer")
		var buffer : UnsafeMutablePointer<GLuint> = ptr.advancedBy(i)
		glBindBuffer(GLenum(GL_ARRAY_BUFFER), buffer.memory)
	}
}