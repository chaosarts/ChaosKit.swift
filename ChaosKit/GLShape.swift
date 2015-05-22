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
in corresponding GLAttribute objects.
*/
public class GLShape : GLDisplayObject {
	
	/*
	|--------------------------------------------------------------------------
	| Stored properties
	|--------------------------------------------------------------------------
	*/
	
	/// Contains the vertex attributes of the shape
	private var _attributes : [GLAttribAlias : GLAttribute] = [GLAttribAlias : GLAttribute]()
	
	///
	private var _textureMaps : [GLTextureMap] = []
	
	/// Provides a list of indices for GL_ELEMENT_ARRAY_BUFFER
	private var _indices : [Int]?
	
	/// Maps positions to indeces
	private var _indexmap : [String : Int] = [String : Int]()
	
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
	public var attributes : [GLAttribAlias : GLAttribute] {get {return _attributes}}
	
	
	/*
	|--------------------------------------------------------------------------
	| Subscripts
	|--------------------------------------------------------------------------
	*/
	
	/**
	Returns the according vertex attribute values as GLAttribute object
	
	:param: attribute An attribute alias
	*/
	public subscript (attribute: GLAttribAlias) -> GLAttribute? {
		get {return _attributes[attribute]}
		set {_attributes[attribute] = newValue}
	}
	
	
	/**
	Returns one attribute value of one vertex
	
	:param: alias An vertex attribute alias
	:param: index The index of the vertex to get the attribute value
	*/
	public subscript (alias: GLAttribAlias, index: Int) -> [GLfloat] {
		get {
			var attribute : GLAttribute? = (self)[alias]
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
		
		_attributes[.Position] = GLAttributeArray(size: 3)
		_attributes[.Color] = GLAttributeArray(size: 4)
		_attributes[.Normal] = GLAttributeArray(size: 3)
		
		_indexWrappers[.Color] = repeatIndex
		_indexWrappers[.Normal] = repeatIndex
		
		if useIndex {
			_vertexBuffer = GLVertexElementBuffer()
		}
		else {
			_vertexBuffer = GLVertexArrayBuffer()
		}
	}
	
	
	/*
	|--------------------------------------------------------------------------
	| Methods
	|--------------------------------------------------------------------------
	*/
	
	/**
	Creates a vertex with given position and set color and normal if set
	
	:param: position The position where the vertex will be set
 	*/
	public func createVertex (position: vec3) {
		
		if _indices != nil {
			var key : String = position.x.description + "-" + position.y.description + "-" + position.z.description
			var index : Int? = _indexmap[key]

			if index != nil {
				_indices!.append(index!)
				return
			}
			
			_indexmap[key] = self[.Position]!.count
		}
		
		if canSetForAlias(.Color) && color != nil {
			_attributes[.Color]!.append(color!.array)
		}
		
		if canSetForAlias(.Normal) && normal != nil {
			_attributes[.Normal]!.append(normal!.array)
		}
		
		_attributes[.Position]!.append(position.array)
		
		_compiled = false
	}
	
	
	/** 
	Creates a vertex with x, y, and z-coordinates
	
	:param: x
	:param: y
	:param: z
	*/
	public func createVertex (x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
		createVertex(vec3(x, y, z))
	}
	
	
	/**
	*/
	public func setAttribute(alias: GLAttribAlias, attribute: GLAttribute) {
		_attributes[alias] = attribute
	}
	
	
	/**
	*/
	public func setAttributeDynamic (alias: GLAttribAlias, bool: Bool = false) {
		_attributes[alias]?.dynamic = bool
	}
	
	
	/**
	Compiles the shape by converting shape vertex data to buffer
	*/
	public func compile () {
		if _compiled {return}
		_vertexBuffer.setup(_attributes)
		_vertexBuffer.buffer(self)
	}
	
	
	/**
	Draws the shape with passed program
	
	:param: program The gl program to use for drawing
	*/
	public override func draw (program: GLProgram) {
		var modelViewUniform : GLUniformLocation? = program.getUniformLocation(.ModelViewMatrix)
		modelViewUniform?.assign(modelViewMatrix)
		
		for buffer in vertexBuffer.buffers {
			buffer.bind()
			for block in buffer.blocks {
				var attribute : GLAttribLocation? = program.getAttribLocation(block.attribute)
				attribute?.enable()
				attribute?.setVertexAttribPointer(block)
			}
			
			glDrawArrays(mode, 0, GLsizei(count))
			
			// Disable all attributes that has been used
			for block in buffer.blocks {
				var attribute : GLAttribLocation? = program.getAttribLocation(block.attribute)
				attribute?.disable()
			}
		}
	}
	
	
	/**
	Determines if an attribute data can be set on createVertex()
	
	:param: alias The alias to check
	*/
	private func canSetForAlias (alias: GLAttribAlias) -> Bool {
		var attribute : GLAttribute? = _attributes[alias]
		var isset : Bool = attribute != nil
		var sameCount : Bool = attribute!.count == self.count
		return isset && sameCount
	}
}