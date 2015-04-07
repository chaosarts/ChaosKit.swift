//
//  GLShape.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL


public class GLShape : GLDisplayObject {
	
	/// Provides the vertice
	private var _vertice : [GLVertex] = [] {didSet {_compiled = false}}
	
	/// Provides the indices for element array buffer
	private var _indices : [Int]?
	
	/// Indicates if the shape has been compiled or not
	private var _compiled : Bool = false
	
	/// Contains the buffer
	private var _buffers : [GLBuffer] = [] {didSet {_compiled = false}}
	
	/// Provides the vertice of the shape
	public var vertice : [GLVertex] {get {return _vertice}}
	
	/// Provides the indices for element array buffer
	public var indices : [Int]? {get {return _indices}}
	
	/// Contains the count of vertice the shape contains
	public var size : Int {get {return _vertice.count}}
	
	/// Provides the draw mode of the shape, such as GL_POINT, GL_TRIANGLE etc
	public var mode : GLenum = GLenum(GL_POINT)
	
	/// Contains the buffer
	public var buffers : [GLBuffer] {
		get {if !_compiled {compile()}; return _buffers}
		set {_buffers = newValue}
	}
	
	
	/** 
	Initializes the shape with a buffer strategy
	*/
	public override init () {
		super.init()
	}
	
	
	/** 
	Adds a new vertex to the shape
	
	:param: vertex The vertex to append to vertice list
	*/
	public func addVertex (vertex: GLVertex) {
		_vertice.append(vertex)
	}
	
	
	public func setVertice (vertice: [GLVertex]) {
		_vertice = vertice
	}
	
	
	public func setIndices (indices: [Int]) {
		_indices = indices
	}
	
	
	private func compile () {
		for buffer in buffers {
			buffer.buffer(vertice)
		}
	}
}


public protocol GLShaper {
	func form () -> GLShape
}