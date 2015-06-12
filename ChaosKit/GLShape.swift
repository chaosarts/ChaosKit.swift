//
//  GLShape.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL

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
	public var mode : GLenum = GLenum(GL_TRIANGLES)
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the bufferables
	public var bufferables : [GLLocationSelector : GLBufferable] {
		get {
			var output : [GLLocationSelector : GLBufferable] = surface.bufferables
			var selector : GLLocationSelector = GLLocationSelector(type: .Position)
			output[selector] = geometry
			return output
		}
	}
	
	
	public var uniforms : [GLLocationSelector : GLUniform] {
		get {
			var uniforms : [GLLocationSelector : GLUniform] = surface.uniforms
			uniforms[GLLocationSelector(type: .ModelViewMatrix)] = GLUniformMatrix4fv(modelViewMatrix)
			uniforms[GLLocationSelector(type: .ProjectionViewMatrix)] = GLUniformMatrix4fv(modelViewMatrix)
			return uniforms
		}
	}
	
	
	/// Provides the shape in the compiled version ready to upload to a program
	public var buffers : [GLBuffer] {
		get {
			_configureBuffers()
			
			if _compiled {return _buffers!}
			
			for buffer in _buffers! {
				var data : [GLfloat] = []
				
				for index in 0..<geometry.count {
					for block in buffer.blocks {
						var bufferable : GLBufferable = bufferables[block.selector]!
						data += bufferable[index]
					}
				}
				
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
		var staticBufferables : [GLLocationSelector : GLBufferable] = [GLLocationSelector : GLBufferable]()
		
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