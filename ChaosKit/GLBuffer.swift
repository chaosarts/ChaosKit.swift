//
//  GLArrayBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 31.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa


public protocol GLBuffer: GLBindable {
	
	/// Provides information about a block within the buffer
	/// The blocks and the order in which, they are added, gives the buffer
	/// information about how to buffer vertex data
	var blocks : [GLBufferBlock] {get}
	
	/// The pointer to the non-zero buffer name
	var ptr : UnsafeMutablePointer<GLuint> {get}
	
	/// Provides the buffer target sucha as GL_ARRAY_BUFFER
	var target : GLenum {get}
	
	/// Contains the stride per vertex
	var stride : GLsizei {get}
	
	/// Contains the count of vertices to draw
	var count : GLsizei {get}
	
	/// Provides the usage of the buffer (GL_STATIC_DRAW)
	var usage : GLenum {get}
	
	func draw ()
	
	func bind ()
	
	func unbind ()
	
	func buffer (vertice: [GLVertex])
	
	func update (offset: Int, vertice: [GLVertex])
	
	func delete ()
}


public class GLBufferBase : GLBase {
	
	/// Provides information about a block within the buffer
	/// The blocks and the order in which, they are added, gives the buffer 
	/// information about how to buffer vertex data
	private var _blocks : [GLBufferBlock] = []
	
	/// Contains the stride per vertex
	private var _stride : Int = 0
	
	/// Contains the count of vertex that are buffered
	private var _count : Int = 0
	
	/// Indicates if the buffer is blocked from adding new blocks
	/// This happens when data is buffered the first time. After
	/// Buffering data, there is no possibility to add new blocks
	private var _locked : Bool = false
	
	/// Contains the pointer to the buffered data
	private var _data : [GLfloat] = []
	
	/// Provides information about a block within the buffer
	/// The blocks and the order in which, they are added, gives the buffer
	/// information about how to buffer vertex data
	public var blocks : [GLBufferBlock] {get {return _blocks}}
	
	/// The pointer to the non-zero buffer name
	public let ptr : UnsafeMutablePointer<GLuint>
	
	/// Provides the buffer target sucha as GL_ARRAY_BUFFER
	public let target : GLenum
	
	/// Contains the stride per vertex
	public var stride : GLsizei {get {return GLsizei(_stride)}}
	
	/// Contains the count of vertices to draw
	public var count : GLsizei {get {return GLsizei(_count)}}
	
	/// Provides the usage of the buffer
	public var usage : GLenum = GLenum (GL_DYNAMIC_DRAW)

	
	/// Initializes the buffer
	public init (target t: Int32) {
		target = GLenum(t)
		
		var buffer : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenBuffers(1, buffer)
		ptr = buffer
		super.init(id: ptr.memory)
	}
	
	
	/** 
	Binds this buffer
	*/
	public func bind () {
		glBindBuffer(target, id)
	}
	
	
	/**
	Undbinds the buffer
	*/
	public func unbind () {
		glBindBuffer(target, 0)
	}
	
	
	/**
	Adds a new block information to this buffer
 	*/
	public func addBlock (block: GLBufferBlock) {
		if _locked {return}
		
		if blocks.count > 1 {
			usage = GLenum(GL_STATIC_DRAW)
		}
		
		// Workaround to modify parameter
		var b = block
		b.offset = GLint(_stride)
		
		_blocks.append(b)
		_stride += Int(b.size)
	}
	
	
	/**
	*/
	public func buffer (vertice: [GLVertex]) {
		_locked = true
		_count = vertice.count
		
		_data = interleave(vertice)
		
		bind()
		glBufferData(target, sizeof(GLfloat) * _data.count, _data, usage)
		unbind()
	}
	
	
	/**
	Updates the buffer
	*/
	public func update (offset: Int, vertice: [GLVertex]) {
		glBufferSubData(target, GLintptr(offset), vertice.count * sizeof(GLfloat), toUnsafeVoidPointer(vertice))
	}
	
	/**
	Interleaves the data for a vertex list
	*/
	private func interleave (vertice: [GLVertex]) -> [GLfloat] {
		var array : [GLfloat] = []
		for vertex in vertice {
			for block in _blocks {
				array.extend(vertex[block.attribute]!.array)
			}
		}
		
		return array
	}
	
	
	public func delete () {
		glDeleteBuffers(1, ptr)
	}
}