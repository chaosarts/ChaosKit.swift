//
//  GLArrayBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 31.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/**
Class wrapper for buffer. This class is used just like 
*/
public class GLBuffer {
	
	/*
	|--------------------------------------------------------------------------
	| Stored properties
	|--------------------------------------------------------------------------
	*/
	
	/// Contains the pointer, which is generated with glGenBuffers()
	private var _ptr : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
	
	/// Provides the count of stored values
	private var _count : Int = 0
	
	private var _blocks : [GLBufferBlock] = []
	
	/// Contains the usage of the buffer
	private var _usage : GLenum
	
	
	/*
	|--------------------------------------------------------------------------
	| Derived properties
	|--------------------------------------------------------------------------
	*/
	
	/// The generated buffer name in pointer
	public var name : GLuint {get {return _ptr.memory}}
	
	/// Provides the count of stored values
	public var count : Int {get {return _count}}
	
	/// Indicates how to read the buffer
	public var blocks : [GLBufferBlock] {get {return _blocks}}
	
	/// Provides the usage of this buffer (GL_STATIC_DRAW, GL_DYNMAIC_DRAW)
	public var usage : GLenum {get {return _usage}}
	
	
	/*
	|--------------------------------------------------------------------------
	| Initializers
	|--------------------------------------------------------------------------
	*/
	
	/**
	Initilaizes the data buffer
	
	:param: usage The usage of this buffer (GL_STATIC_DRAW, GL_DYNAMIC_DRAW)
	*/
	public init (usage: Int32, blocks: [GLBufferBlock]) {
		_usage = GLenum(usage)
		_blocks = blocks
		glGenBuffers(1, _ptr)
	}
	
	
	/*
	|--------------------------------------------------------------------------
	| Methods
	|--------------------------------------------------------------------------
	*/
	
	/**
	Buffers the buffer to the targeted buffer
	
	:param: target The targeted buffer (GL_ARRAY_BUFFER, GL_ELEMENT_ARRAY_BUFFER)
	:param: data The data to buffer
	*/
	public func buffer (target: Int32, _ data: [GLfloat]) {
		buffer(GLenum(target), data)
	}
	
	
	public func buffer (target: GLenum, _ data: [GLfloat]) {
		bind(target)
		_count = data.count
		glBufferData(target, data.count * sizeof(GLfloat), data, usage)
		unbind(target)
	}
	
	
	/**
	Updates sub data in the buffer
	
	:param: target The targeted buffer type
	:param: data The sub data to buffer
	*/
	public func update (target: Int32, data: [GLfloat], offset: Int) {
		update(GLenum(target), data: data, offset: offset)
	}
	
	
	/**
	Updates sub data in the buffer
	
	:param: target The targeted buffer type
	:param: data The sub data to buffer
	*/
	public func update (target: GLenum, data: [GLfloat], offset: Int) {
		bind(target)
		glBufferSubData(target, GLintptr(offset) , data.count * sizeof(GLfloat), data)
		unbind(target)
	}
	
	
	/**
	Binds the buffer with passed target
	
	:param: target The targeted buffer
 	*/
	public func bind (target: Int32) {
		bind(GLenum(target))
	}
	
	
	/**
	Binds the buffer with passed target
	
	:param: target The targeted buffer
	*/
	public func bind (target: GLenum) {
		glBindBuffer(target, name)
	}
	

	/**
	Binds the buffer with passed target
	
	:param: target The targeted buffer
	*/
	public func unbind (target: Int32) {
		unbind(GLenum(target))
	}
	
	
	/** 
	Frees the buffer
	
	:param: target
	*/
	public func unbind (target: GLenum) {
		glBindBuffer(target, 0)
	}
	
	
	/**
	Deletes the internal buffer
 	*/
	internal func delete () {
		_count = 0
		glDeleteBuffers(1, _ptr)
	}
}