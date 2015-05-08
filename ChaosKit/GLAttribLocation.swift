//
//  Attribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/*
|--------------------------------------------------------------------------
| Attribute Type Enumeration
|--------------------------------------------------------------------------
*/

/**
Enumerates the types of reasonable attributes in a vertex shader program. 
It represents a attribute variable within a cocoa program without knowing 
the name of the variable. With the help of GLAttributeInfo objects  
this a GLProgram object establishes the connection between a 
concrete variable in a shader program with this enumeration cases.

- Color: Stands for the color attribute variable
- Normal: Stands for the normal attribute variable
- Position: Stands for the position attribute variable
- TexCoord: Stands for the texture coordinate attribute variable
*/
public enum GLAttribAlias : String {
	
	/// Stands for the color attribute variable
	case Color = "Color"
	
	/// Stands for the normal attribute variable
	case Normal = "Normal"
	
	/// Stands for the position attribute variable
	case Position = "Position"
	
	/// Stands for the texture coordinate attribute variable
	case TexCoord = "TexCoord"
	
	static let cases : [GLAttribAlias] = [.Color, .Normal, .Position, .TexCoord]
}


/*
|--------------------------------------------------------------------------
| AttribLocation
|--------------------------------------------------------------------------
*/

public struct GLAttribLocation {
	
	private let ptr : UnsafeMutablePointer<Void>
	
	/// The representative attribute location
	public let id : GLuint
	
	/// The variable name of the attribute
	public let name : String
	
	
	
	/**
	Initializes the attribute location
	
	:param: index The attribute location fetched by glGetAttribLocation
	:param: name The string variable name of the attribute
	:param: type The glsl data type
	:param: size The size of the variable
	*/
	public init (index: GLuint, name: String, pointer: UnsafeMutablePointer<Void>) {
		self.id = index
		self.name = name
		self.ptr = pointer
	}
	
	
	/** 
	En- or disables the attribute location for the accroding program
	
	:param: enable
	*/
	public func setEnabled (enable: Bool) {
		if enable {self.enable()}
		else {self.disable()}
	}
	
	
	/**
	Shortcut for glGetVertexAttribPointerv
	
	:return: The pointer to the attribute
	*/
	public mutating func getVertexAttribPointer () -> UnsafeMutablePointer<Void> {
		return ptr
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	:param: block The buffer block that holds the information for the attribute within the accroding buffer
	*/
	public func setVertexAttribPointer (block: GLBufferBlock, pointer: UnsafeMutablePointer<Void>) {
		var floatSize : Int = sizeof(GLfloat)
		setVertexAttribPointer(block.size, block.type, block.normalized, GLsizei(floatSize) * block.stride, pointer)
	}
	
	
	/** 
	Shortcut for glVertexAttribPointer
	
	:param: block The buffer block that holds the information for the attribute within the accroding buffer
	*/
	public mutating func setVertexAttribPointer (block: GLBufferBlock) {
		var floatSize : Int = sizeof(GLfloat)
		setVertexAttribPointer(block, pointer: ptr.advancedBy(floatSize * block.offset))
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	:param: size The size of the attribute value per vertex in the buffer
	:param: type The data type of an element of an attribute values
	:param: normalized
	:param: stride
	:param: pointer
	*/
	public func setVertexAttribPointer (size: GLint, _ type: GLenum, _ normalized: GLboolean, _ stride: GLsizei, _ pointer: UnsafeMutablePointer<Void>) {
		glVertexAttribPointer(id, size, type, normalized, stride, pointer)
	}
	
	/**
	Enables the attribute for the program
	*/
	public func enable () {
		glEnableVertexAttribArray(id)
	}
	
	/**
	Disables the attribute for the program
	*/
	public func disable () {
		glDisableVertexAttribArray(id)
	}
}