//
//  Shape.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL


public class Shape : DisplayObject, Bufferable {
	
	public class func defaultBufferStrategy () -> BufferStrategy {
		return DefaultBufferStrategy()
	}
	
	/// Provides the vertice
	private var _vertice : [Vertex] = []
	
	/// Contains the buffer object for this shape
	private var _buffers : [Buffer]?
	
	/// Contains the strategy how to buffer this shape
	private var _strategy : BufferStrategy
	
	/// Contains the strategy how to buffer this shape
	private var _compiled : Bool = true
	
	/// Provides the vertice of the shape
	public var vertice : [Vertex] {get {return _vertice}}
	
	/// Contains the count of vertice the shape contains
	public var size : Int {get {return _vertice.count}}
	
	/// Contains the buffer object for this shape
	public var buffers : [Buffer] {
		get {
			if _buffers == nil {compile()}
			return _buffers!
		}
	}
	
	
	/** 
	Initializes the shape with a buffer strategy
	
	:param: bufferstrategy
	*/
	public init (strategy: BufferStrategy) {
		_strategy = strategy
		super.init()
	}
	
	
	public func draw (program: Program) {
		for buffer in buffers {
			buffer.bind()
			glBindBuffer(buffer.target, 0)
		}
	}
	
	
	/** 
	Adds a new vertex to the shape
	
	:param: vertex The vertex to append to vertice list
	*/
	public func addVertex (vertex: Vertex) {
		_vertice.append(vertex)
	}
	
	
	/**
	Compiles the shape to a buffer object
	*/
	public func compile () {
		_buffers = _strategy.buffer(self)
	}
}