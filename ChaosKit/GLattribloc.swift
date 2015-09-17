//
//  Attribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

/**
Struct that holds information about a attribute location in a program.
*/
public struct GLattribloc : GLLocation {
	
	/// Provides the vertex attribute pointer
	private var _ptr :  UnsafeMutablePointer<UnsafeMutablePointer<Void>>
	
	/// Provides the attribute location index
	public let index : GLuint
	
	/// Provides the variable name of the attribute
	public let name : String
	
	/// Provides the description of this location as string
	public var description : String {
		get {return "\(name) (id: \(index))"}
	}
	
	/**
	Initializes the attribute location
	
	- parameter index: The attribute location fetched by glGetAttribLocation
	- parameter name: The string variable name of the attribute
	*/
	public init (index: GLuint, name: String) {
		self.index = index
		self.name = name
		
		_ptr = UnsafeMutablePointer<UnsafeMutablePointer<Void>>.alloc(1)
		glGetVertexAttribPointerv(index, GLenum(GL_VERTEX_ATTRIB_ARRAY_POINTER), _ptr)
	}
	
	
	/**
	En- or disables the attribute location for the accroding program
	
	- parameter enable:
	*/
	public func setEnabled (enable: Bool) {
		if enable {self.enable()}
		else {self.disable()}
	}
	
	
	/**
	Shortcut for glGetVertexAttribPointerv
	
	:return: The pointer to the attribute
	*/
	public func getVertexAttribPointer () -> UnsafeMutablePointer<Void> {
		return _ptr.memory
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	- parameter block: The buffer block that holds the information for the attribute within the accroding buffer
	*/
	public func setVertexAttribPointer (block: GLBufferBlock) {
		var floatSize : Int = sizeof(GLfloat)
		setVertexAttribPointer(block.size, block.type, block.normalized, block.stride, block.offset)
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	- parameter size: The size of the attribute value per vertex in the buffer
	- parameter type: The data type of an element of an attribute values
	- parameter normalized:
	- parameter stride:
	- parameter pointer:
	*/
	public func setVertexAttribPointer (size: GLint, _ type: GLenum, _ normalized: Bool, _ stride: Int) {
		setVertexAttribPointer(size, type, normalized, stride, _ptr.memory)
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	- parameter size: The size of the attribute value per vertex in the buffer
	- parameter type: The data type of an element of an attribute values
	- parameter normalized:
	- parameter stride:
	- parameter pointer:
	*/
	public func setVertexAttribPointer (size: GLint, _ type: GLenum, _ normalized: Bool, _ stride: Int, _ offset: Int) {
		setVertexAttribPointer(size, type, normalized, stride, _ptr.memory.advancedBy(sizeof(GLfloat) * offset))
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	- parameter size: The size of the attribute value per vertex in the buffer
	- parameter type: The data type of an element of an attribute values
	- parameter normalized:
	- parameter stride:
	- parameter pointer:
	*/
	public func setVertexAttribPointer (size: GLint, _ type: GLenum, _ normalized: Bool, _ stride: Int, _ pointer: UnsafeMutablePointer<Void>) {
		glVertexAttribPointer(index, size, type, GLboolean(normalized ? GL_TRUE : GL_FALSE), GLsizei(stride * sizeof(GLfloat)), pointer)
	}
	
	/**
	Enables the attribute for the program
	*/
	public func enable () {
		glEnableVertexAttribArray(index)
	}
	
	/**
	Disables the attribute for the program
	*/
	public func disable () {
		glDisableVertexAttribArray(index)
	}
}

