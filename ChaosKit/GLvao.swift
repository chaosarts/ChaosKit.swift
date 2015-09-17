//
//  GLVertexArray.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.08.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

public struct GLvao {
	
	/// Provides the id of the vertex array
	public let id : GLuint
	
	
	// INITIALIZERS
	// ++++++++++++
	
	/**
	Initializes the vertex array with given id
	
	:param: id The vertex array id
 	*/
	public init (_ id: GLuint) {
		self.id = id
	}
	
	
	/**
	Initializes the vertex array and generates an id
	*/
	public init? () {
		var vao : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenVertexArrays(1, vao)
		if vao.memory == 0 {return nil}
		
		self.init(vao.memory)
		vao.dealloc(1)
		vao.destroy()
	}
	
	
	// METHODS
	// +++++++
	
	public func bind () {
		glBindVertexArray(id)
	}
	
	
	public func unbind () {
		glBindVertexArray(0)
	}
}