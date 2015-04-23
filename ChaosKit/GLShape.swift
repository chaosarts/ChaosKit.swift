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
The base class for a 3d object in open gl
*/
public class GLShape : GLDisplayObject {
	
	// STORED VALUES
	// *************
	
	/// Provides the vertice of the shape
	private var _vertice : [GLVertex] = []
	
	/// Contains the color to use for next vertex to create
	private var _color : vec4?
	
	/// Indicates if the shape has already been buffered or not
	private var _buffered : Bool = false
	
	/// Provides the buffers of this shape
	private var _buffers : [GLBuffer] = [] {
		didSet {_buffered = false}
	}
	
	/// The draw mode of the shape
	public var mode : GLenum = GLenum(GL_TRIANGLES)
	
	
	// DERIVED VALUES
	// **************
	
	/// Color to use for next vertex
	public var color : vec4? {
		get {return _color}
		set {if vertice.count == 0 || newValue != nil {_color = newValue}}
	}
	
	/// Provides the vertice of the shape
	public var vertice : [GLVertex] {
		get {return _vertice}
	}
	
	
	/// Provide the buffers of this shape
	public var buffers : [GLBuffer] {
		get {compile(); return _buffers}
		set {_buffers = newValue}
	}
	
	// SUBSCRIPTS 
	// **********
	
	/// Access to a single vertex of the shape
	public subscript (index: Int) -> GLVertex? {
		get {return _vertice[index]}
	}
	
	
	/** Initialzes the Shape */
	public override init () {}
	
	
	/**
	Creates a new vertex of the shape at given position with given normal
	
	:param: position The position of the vertex
	:param: normal The normal at this vertex position
	*/
	public func createVertex (position p: vec3, normal n: vec3) {
		var vertex : GLVertex = GLVertex()
		vertex[.Position] = GLVertexAttributeData<vec3>(p)
		vertex[.Normal] = GLVertexAttributeData<vec3>(n)
		
		if color != nil {
			vertex[.Color] = GLVertexAttributeData<vec4>(color!)
		}
	}
	
	
	private func compile () {
		if _buffered {return}
		
		for buffer in _buffers {
			buffer.buffer(vertice)
		}
	}
}


public protocol GLShaper {
	func form () -> GLShape
}