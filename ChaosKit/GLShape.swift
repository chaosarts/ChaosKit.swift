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
	
	/// Provides the target
	public private(set) var target : GLBufferTarget = GLArrayBufferTarget()

	/// Provides the geometry
	public var geometry : GLGeometry {
		willSet {if geometry.dynamic != newValue.dynamic {_buffers = nil}}
		didSet {_compiled = false}
	}
	
	/// Provides the surface
	public var surface : GLSurface = GLSurface()
	
	/// Provides the line width
	public var linewidth : GLfloat = 1
	
	/// Provides the point size
	public var pointsize : GLfloat = 1
	
	/// Provides the draw mode
	public var modes : [GLenum] = [GLenum(GL_TRIANGLES)]
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Contains the model view matrix
	internal var normalTransformation : mat3 {
		get {return transformation.submatrix(row: 3, col: 3)}
	}
	
	/// Provides the bufferables
	public var bufferables : [GLurl : GLBufferable] {
		// Since this dictionary will mainly be called for buffering,
		// it's okay to generate the dictionary, without caching
		get {
			// Get the bufferables from surface
			var bufferables : [GLurl : GLBufferable] = surface.bufferables
			
			// Append geometry and normals (if set)
			bufferables[GLurl(.Vertex, .Position)] = geometry
			if geometry.normals != nil {bufferables[GLurl(.Vertex, .Normal)] = geometry.normals!}
			
			return bufferables
		}
	}
	
	
	/// Returns all uniforms for a draw call
	public var uniforms : [GLurl : GLUniform] {
		
		// Like bufferables, this generates a dictionary of GLurl to GLUniform
		// This may need to be cached, since it will be called at each draw
		// operation.
		get {
			if _uniforms == nil {
				_uniforms = [GLurl : GLUniform]()
				_uniforms![GLurl(.Model, .Transformation)] = GLUniformMatrix4fv(transformation)
				_uniforms![GLurl(.Normal, .Transformation)] = GLUniformMatrix3fv(normalTransformation)
			}
			
			return surface.uniforms + _uniforms!
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
			var bufferables : [GLurl : GLBufferable] = self.bufferables
			
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
						var bufferable : GLBufferable = bufferables[block.selector]!
						data += bufferable[index]
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
	public init (geometry: GLGeometry) {
		self.geometry = geometry
	}
	
	
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
		var staticBufferables : [GLurl : GLBufferable] = [GLurl : GLBufferable]()
		
		// Store the stride
		var stride : Int = 0
		
		// Configure dynamic buffers and preconfigure static buffer
		for selector in bufferables.keys {
			
			var bufferable : GLBufferable = bufferables[selector]!
			
			// Handle only non-dynmaic buffers
			if bufferable.dynamic {
				/// Creates one buffer per dynamic
				var block : GLBufferBlock = GLBufferBlock(selector, bufferable.size, GL_FLOAT, true, 0, 0)
				var buffer : GLBuffer = GLBuffer(target: target.value, usage: GLenum(GL_DYNAMIC_DRAW), blocks: [block])
				_buffers!.append(buffer)
				continue
			}
			
			// Append buffer to static group
			staticBufferables[selector] = bufferable
			
			// Increase stride with new appended static attribute
			stride += bufferable.size
		}
		
		
		// Configure the static buffer
		var offset : Int = 0
		var blocks : [GLBufferBlock] = []
		for selector in staticBufferables.keys {
			var bufferable : GLBufferable = bufferables[selector]!
			var block : GLBufferBlock = GLBufferBlock(selector, bufferable.size, GL_FLOAT, true, stride, offset)
			blocks.append(block)
			offset += Int(block.size)
		}
		
		_buffers!.append(GLBuffer(target: target.value, usage: GLenum(GL_STATIC_DRAW), blocks: blocks))
		target = geometry.indexed ? GLElementBufferTarget(indices: geometry.indexlist!) : GLArrayBufferTarget()
		_compiled = false
	}
}