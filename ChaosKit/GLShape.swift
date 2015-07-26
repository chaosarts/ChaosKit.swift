//
//  GLShape.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL

/*
|--------------------------------------------------------------------------
| Shape class
|--------------------------------------------------------------------------
*/

/**
The base class for a 3d object in OpenGL. A shape is described by different 
types of attributes (Position, Color, Normals) as lists of vectors contained 
in corresponding GLAttribData objects.
*/
@objc
public class GLShape : GLDisplayObject {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides a list of buffer objects, which are to use when configuring this vertex array
	private var _buffers : [GLBuffer]?
	
	/// Indicates whether the shape is compiled or not
	private var _compiled : Bool = false
	
	/// Provides the normal transformation in case for shearing or scaling
	internal var _normalTransformation : mat4?

	/// Provides the geometry
	public var geometry : GLgeom = GLgeom() {
		didSet {_compiled = false}
	}
	
	/// Provides the surface
	public var surface : GLSurface = GLSurface()
	
	/// Provides a map of additional not yet directly supported properties
	public var additionalProperties : [GLurl : GLAttribute] = [GLurl : GLAttribute]()
	
	/// Provides the line width
	public var linewidth : GLfloat = 1
	
	/// Provides the point size
	public var pointsize : GLfloat = 1
	
	/// Provides the draw mode
	public var mode : GLenum = GLenum(GL_TRIANGLES)
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the target
	public var target : GLBufferTarget {
		get {return geometry.forElementBuffer ? GLElementBufferTarget(indices: geometry.indexlist) : GLArrayBufferTarget()}
	}
	
	/// Contains the model view matrix
	public var normalTransformation : mat4 {
		get {
			if nil != _normalTransformation {return _normalTransformation! * transformation}
			return transformation
		}
	}
	
	/// Provides the bufferables
	public var bufferables : [GLurl : GLAttribute] {
		// Since this dictionary will mainly be called for buffering,
		// it's okay to generate the dictionary, without caching
		get {
			// Get the bufferables from surface
			var bufferables : [GLurl : GLAttribute] = additionalProperties + surface.bufferables
			
			// Append geometry and normals (if set)
			bufferables[GLUrlVertexPosition] = geometry
			return bufferables
		}
	}
	
	
	/// Returns all uniforms for a draw call
	public var uniforms : [GLurl : GLUniform] {
		
		// NOTE: No cache possibilities found yet, since at this point
		// it is unknown if there are changes in transformation for the parent
		// object
		get {
			var	uniforms : [GLurl : GLUniform] = [GLurl : GLUniform]()
			uniforms[GLUrlModelViewMatrix] = GLuniformMat4fv(transformation)
			uniforms[GLUrlNormalViewMatrix] = GLuniformMat4fv(normalTransformation)
			return surface.uniforms + uniforms
		}
	}
	
	
	/// Provides the shape in the compiled version ready to upload to a program
	public var buffers : [GLBuffer] {
		get {
			_configureBuffers()
			
			if _compiled {return _buffers!}
			
			/// Since calling self.bufferables will always have to generate
			/// the dictionary, store it in a local variable. May save a little
			/// time.
			var bufferables : [GLurl : GLAttribute] = self.bufferables
			
			/// It can be assumed, that after _configureBuffer call, that
			/// buffers are available
			for buffer in _buffers! {
				
				/// Stores the data of the current buffer in this loop
				var data : [GLfloat] = []
				
				/// Fetch data with the count of vertice in geometry
				/// Make sure all other properties serve at least the
				/// same amount of values.
				for index in 0..<geometry.count {
					
					/// Read how to format the data for the buffer
					for block in buffer.blocks {
						var bufferable : GLAttribute = bufferables[block.url]!
						data += bufferable.getValue(atIndex: index)
					}
				}
				
				/// Finally buffering
				buffer.bind()
				buffer.buffer(data)
			}
			
			_compiled = true
			
			return _buffers!
		}
	}

	
	// INITIALIZERS
	// ++++++++++++
	
	/** 
	Initialzes the Shape 
	*/
	public init (_ geometry: GLGeometry) {
		self.geometry = geometry
	}
	
	
	/**
	Initialzes an empty shape
	*/
	public override init () {}
	
	
	// METHODS
	// +++++++
	
	
	/**
	Configures the buffers
	*/
	private func _configureBuffers () {
		if nil != _buffers {return}
		
		// Group by dynmaic and static attributes
		// **************************************
		
		_buffers = []
		
		// Store static bufferables in this array to configure static buffer later
		var staticBufferables : [GLurl : GLAttribute] = [GLurl : GLAttribute]()
		
		// Store the stride
		var stride : Int = 0
		
		// Configure dynamic buffers and preconfigure static buffer
		for url in bufferables.keys {
			
			var bufferable : GLAttribute = bufferables[url]!
			
			// Handle only non-dynmaic buffers
			if bufferable.dynamic {
				/// Creates one buffer per dynamic
				var block : GLBufferBlock = GLBufferBlock(url, bufferable.size, GL_FLOAT, true, 0, 0)
				var buffer : GLBuffer = GLBuffer(target: target.value, usage: GLenum(GL_DYNAMIC_DRAW), blocks: [block])
				_buffers!.append(buffer)
				continue
			}
			
			// Append buffer to static group
			staticBufferables[url] = bufferable
			
			// Increase stride with new appended static attribute
			stride += bufferable.size
		}
		
		
		// Configure the static buffer
		var offset : Int = 0
		var blocks : [GLBufferBlock] = []
		for url in staticBufferables.keys {
			var bufferable : GLAttribute = bufferables[url]!
			var block : GLBufferBlock = GLBufferBlock(url, bufferable.size, GL_FLOAT, true, stride, offset)
			blocks.append(block)
			offset += Int(block.size)
		}
		
		_buffers!.append(GLBuffer(target: target.value, usage: GLenum(GL_STATIC_DRAW), blocks: blocks))
		target = geometry.useIndexlist ? GLElementBufferTarget(indices: geometry.indexlist) : GLArrayBufferTarget()
		_compiled = false
	}
}