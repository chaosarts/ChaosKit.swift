//
//  GLArrayBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 31.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL
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
	
	/// Provides the target of the buffer. This is used for glBindBuffer or glBufferData
	private var _target : GLenum
	
	private lazy var _bindingPname : GLenum = self._target == GLenum(GL_ARRAY_BUFFER) ? GLenum(GL_ARRAY_BUFFER_BINDING) : GLenum(GL_ELEMENT_ARRAY_BUFFER_BINDING)
	
	
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
	
	/// Provides the target of the buffer. This is used for glBindBuffer or glBufferData
	public var target : GLenum {get {return _target}}
	
	/// Indicates if the buffer is bound or not
	public var bound : Bool {get {return GLuint(GL.getIntegerv(_bindingPname)) == name}}

	
	/*
	|--------------------------------------------------------------------------
	| Initializers
	|--------------------------------------------------------------------------
	*/
	
	
	/** 
	Initalizes the buffer
	*/
	public init (target: GLenum, usage: GLenum, blocks: [GLBufferBlock] = []) {
		_target = target
		_usage = usage
		_blocks = blocks
		_bindingPname = target == GLenum(GL_ARRAY_BUFFER) ? GLenum(GL_ARRAY_BUFFER_BINDING) : GLenum(GL_ELEMENT_ARRAY_BUFFER_BINDING)
		glGenBuffers(1, _ptr)
	}
	
	
	/**
	Initilaizes the data buffer
	
	:param: usage The usage of this buffer (GL_STATIC_DRAW, GL_DYNAMIC_DRAW)
	*/
	public convenience init (target: Int32, usage: Int32, blocks: [GLBufferBlock] = []) {
		self.init(target: GLenum(target), usage: GLenum(usage), blocks: blocks)
	}
	
	public convenience init (blocks: [GLBufferBlock] = []) {
		self.init(target: GLenum(GL_ARRAY_BUFFER), usage: GLenum(GL_STATIC_DRAW), blocks: blocks)
	}
	
	/*
	|--------------------------------------------------------------------------
	| Methods
	|--------------------------------------------------------------------------
	*/
	
	
	public func iv (pname: Int32) -> GLint {
		var params : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		glGetBufferParameteriv(target, GLenum(pname), params)
		return params.memory
	}
	
	/**
	Buffers the buffer to the targeted buffer
	
	:param: target The targeted buffer (GL_ARRAY_BUFFER, GL_ELEMENT_ARRAY_BUFFER)
	:param: data The data to buffer
	*/
	public func buffer (data: [GLfloat]) {
		_count = data.count
		glBufferData(target, data.count * sizeof(GLfloat), data, usage)
	}
	
	/**
	Updates sub data in the buffer
	
	:param: target The targeted buffer type
	:param: data The sub data to buffer
	*/
	public func update (data: [GLfloat], offset: Int) {
		glBufferSubData(target, GLintptr(offset) , data.count * sizeof(GLfloat), data)
	}
	
	
	/**
	Binds the buffer with passed target
	
	:param: target The targeted buffer
 	*/
	public func bind () {
		glBindBuffer(target, name)
	}
	
	
	/** 
	Frees the buffer
	
	:param: target
	*/
	public func unbind () {
		glBindBuffer(target, 0)
	}
	
	
	/**
	Deletes the internal buffer
 	*/
	internal func delete () {
		_count = 0
		glDeleteBuffers(1, _ptr)
	}
	
	
	deinit {
		delete()
		_ptr.destroy()
		_ptr.dealloc(1)
	}
}