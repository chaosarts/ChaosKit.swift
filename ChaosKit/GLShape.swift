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
in corresponding GLVertexAttribute objects.
*/
public class GLShape : GLDisplayObject {
	
	/*
	|--------------------------------------------------------------------------
	| Stored properties
	|--------------------------------------------------------------------------
	*/
	
	private var _attributes : [GLAttribAlias : GLVertexAttribute] = [GLAttribAlias : GLVertexAttribute]()
	
	/// Provides a list of indices for GL_ELEMENT_ARRAY_BUFFER
	private var _indexlist : [Int]?
	
	/// indexWrapper functions for the attributes values in case
	/// their values count won't match the position count
	private var _indexWrappers : [GLAttribAlias : CKIndexWrapper] = [GLAttribAlias : CKIndexWrapper]()
		
	/// Provides the vertex buffer object for this shape
	private var _vertexBuffer : GLVertexBuffer
	
	/// Indicates if the shape is dirty according to the vertex buffer
	private var _setup : Bool = false
	
	/// Indicates if the shape has been compile or not
	private var _compiled : Bool = false
	
	
	/*
	|--------------------------------------------------------------------------
	| Derived properties
	|--------------------------------------------------------------------------
	*/
	
	
	/// Contains the count of vertice of this shape
	public var count : Int {
		get {return _attributes[.Position]!.count}
	}
	
	/// Provides the color to use for next vertex
	public var color : vec4?
	
	/// Provides the normal to use for next vertex, if provided
	public var normal : vec3?
	
	/// Provides the vertex buffer object for this shape
	public var vertexBuffer : GLVertexBuffer {
		get {compile(); return _vertexBuffer}
	}
	
	/// Provides the draw mode
	public var mode : GLenum {
		get {return _vertexBuffer.mode}
		set {_vertexBuffer.mode = newValue}
	}
	
	/// Provides a map of vertex attribute values, where key is the
	/// targeted attribute and value the vertex attribute values
	public var attributes : [GLAttribAlias : GLVertexAttribute] {get {return _attributes}}
	
	
	/*
	|--------------------------------------------------------------------------
	| Subscripts
	|--------------------------------------------------------------------------
	*/
	
	/**
	Returns the according vertex attribute values as GLVertexAttribute object
	
	:param: attribute An attribute alias
	*/
	public subscript (attribute: GLAttribAlias) -> GLVertexAttribute? {
		get {return _attributes[attribute]}
	}
	
	
	/**
	Returns one attribute value of one vertex
	
	:param: alias An vertex attribute alias
	:param: index The index of the vertex to get the attribute value
	*/
	public subscript (alias: GLAttribAlias, index: Int) -> [GLfloat] {
		get {
			var attribute : GLVertexAttribute? = (self)[alias]
			if attribute == nil || attribute!.count == 0 {return []}
			
			var newIndex : Int = index
			if alias != .Position {
				newIndex = _indexWrappers[alias]!(val: index, minVal: 0, maxVal: attribute!.count)
			}
			return attribute![newIndex]
		}
	}

	
	/*
	|--------------------------------------------------------------------------
	| Initializers
	|--------------------------------------------------------------------------
	*/
	
	/** 
	Initialzes the Shape 
	*/
	public convenience override init () {
		self.init(useIndex: false)
	}
	
	
	public init (useIndex: Bool) {
		
		_attributes[.Position] = GLVertexAttributeArray<vec3>()
		_attributes[.Color] = GLVertexAttributeArray<vec4>()
		_attributes[.Normal] = GLVertexAttributeArray<vec3>()
		
		_indexWrappers[.Color] = repeatIndex
		_indexWrappers[.Normal] = repeatIndex
		
		if useIndex {_vertexBuffer = GLVertexElementBuffer()}
		else {_vertexBuffer = GLVertexArrayBuffer()}
	}
	
	
	/*
	|--------------------------------------------------------------------------
	| Methods
	|--------------------------------------------------------------------------
	*/
	
	
	public func draw (program: GLProgram) {
		for buffer in vertexBuffer.buffers {
			buffer.bind()
			for block in buffer.blocks {
				var attribute : GLAttribLocation? = program.getAttribLocation(block.attribute)
				attribute?.enable()
				attribute?.setVertexAttribPointer(block)
			}
			
			glDrawArrays(mode, 0, GLsizei(count))
		}
	}
	
	/**
	Creates a vertex with given position and set color and normal if set
	
	:param: position The position where the vertex will be set
 	*/
	public func createVertex (position: vec3) {
		
		if canSetForAlias(.Color) && color != nil {
			_attributes[.Color]!.append(color!.array)
		}
		
		if canSetForAlias(.Normal) && normal != nil {
			_attributes[.Normal]!.append(normal!.array)
		}
		
		_attributes[.Position]!.append(position.array)
		_compiled = false
	}
	
	
	public func compile () {
		if _compiled {return}
		setupBuffer()
		_vertexBuffer.buffer(self)
	}
	
	
	private func setupBuffer () {
		
		if _setup {return}
		
		// Group by dynmaic and static attributes
		// **************************************
		
		// Assign all attribute values to dynamic group and filter one by one to static
		var dynamicAttributes : [GLAttribAlias : GLVertexAttribute] = _attributes
		var staticAttributes : [GLAttribAlias : GLVertexAttribute] = [GLAttribAlias : GLVertexAttribute]()
		
		// Memorize the stride for static attributes
		var stride : Int = 0
		var buffers : [GLBuffer] = []
		
		// This loop iterates through the dynamic attribute group, configures
		// the buffers and moves the static attributes to a separate group
		for key in dynamicAttributes.keys {
			var attribute : GLVertexAttribute = dynamicAttributes[key]!
			
			// Handle only non-dynmaic buffers
			if attribute.dynamic {
				/// Creates one buffer per dynamic
				var block : GLBufferBlock = GLBufferBlock(key, attribute.size, GL_FLOAT, true, 0, 0)
				var buffer : GLBuffer = GLBuffer(target: _vertexBuffer.target, usage: GLenum(GL_DYNAMIC_DRAW), blocks: [block])
				buffers.append(buffer)
				continue
			}
			
			// Do not add empty attributes
			if attribute.count == 0 {continue}
			
			// Append attribute to static group and remove it from dynamic
			staticAttributes[key] = attribute
			dynamicAttributes.removeValueForKey(key)
			
			// Increase stride with new appended static attribute
			stride += attribute.size
		}
		
		// Configure the static buffer
		var offset : Int = 0
		var sBlocks : [GLBufferBlock] = []
		for key in staticAttributes.keys {
			var attribute : GLVertexAttribute = staticAttributes[key]!
			var block : GLBufferBlock = GLBufferBlock(key, attribute.size, GL_FLOAT, true, stride, offset)
			sBlocks.append(block)
			offset += Int(block.size)
		}
		
		buffers.append(GLBuffer(target: _vertexBuffer.target, usage: GLenum(GL_STATIC_DRAW), blocks: sBlocks))
		_vertexBuffer.buffers = buffers
		
		_setup = true
	}
	
	
	private func canSetForAlias (alias: GLAttribAlias) -> Bool {
		var attribute : GLVertexAttribute? = _attributes[alias]
		var isset : Bool = attribute != nil
		var sameCount : Bool = attribute!.count == self.count
		return isset && sameCount
	}
}


public protocol GLShaper {
	func form () -> GLShape
}