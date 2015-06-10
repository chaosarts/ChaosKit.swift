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
the name of the variable. With the help of GLAttribDataInfo objects  
this a GLProgram object establishes the connection between a 
concrete variable in a shader program with this enumeration cases.

*/
public enum GLAttributeType : String {
	
	/// Represents the color attribute variable
	case Color = "Color"
	
	/// Represents the normal attribute variable
	case Normal = "Normal"
	
	/// Represents the position attribute variable
	case Position = "Position"
	
	/// Represents the texture coordinate attribute variable
	case TexCoord = "TexCoord"

	
	static let all : [GLAttributeType] = [
		.Color,
		.Normal,
		.Position,
		.TexCoord
	]
}


/**
This struct is used to select attribute locations from a GLProgram object
anonymously.
*/
public struct GLAttributeSelector : Printable, StringLiteralConvertible, Hashable {
	
	private static var _delimiter : Character = "@"
	
	/// Defines the domain to specialize the context
	private let _domain : String
	
	/// The attribute type
	private let _type : String
	
	/// String representation of the selector
	public var description : String {
		get {
			var suffix : String = ""
			if _domain != "" {suffix = String(GLAttributeSelector._delimiter) + _domain}
			return _type + suffix
		}
	}
	
	/// Hashvalue representation
	public var hashValue: Int {get{return description.hashValue}}
	
	
	/**
	Initializes the selector with given type and domain
	
	:param: type The type name for the anonymous attribute location
	:param: domain The domain to specify the context
	*/
	public init (type: GLAttributeType, domain: String = "") {
		self.init (type: type.rawValue, domain: domain)
	}
	
	
	/**
	Initializes the selector with given type and domain
	
	:param: type The type name for the anonymous attribute location
	:param: domain The domain to specify the context 
	*/
	public init (type: String, domain: String = "") {
		_type = type
		_domain = domain
	}
	
	
	public init(stringLiteral value: String) {
		var splits = split(value, maxSplit: 1, allowEmptySlices: false,
			isSeparator: {(value: Character) -> Bool in return value == GLAttributeSelector._delimiter})
		if splits.count > 1 {
			self.init(type: splits[1], domain: splits[0])
		}
		else {
			self.init(type: splits[0])
		}
	}
	
	
	public init(unicodeScalarLiteral value: String) {
		self.init(stringLiteral: value)
	}
	
	
	public init(extendedGraphemeClusterLiteral value: String) {
		self.init(stringLiteral: value)
	}
}


public func ==(left: GLAttributeSelector, right: GLAttributeSelector) -> Bool {
	return left.description == right.description
}

/*
|--------------------------------------------------------------------------
| AttribLocation
|--------------------------------------------------------------------------
*/

public class GLAttribLocation : GLLocation {
	
	private let _ptr : UnsafeMutablePointer<Void>	
	
	/**
	Initializes the attribute location
	
	:param: index The attribute location fetched by glGetAttribLocation
	:param: name The string variable name of the attribute
	:param: type The glsl data type
	:param: size The size of the variable
	*/
	public init (index: GLuint, name: String, pointer: UnsafeMutablePointer<Void>) {
		_ptr = pointer
		super.init(index, name)
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
	public func getVertexAttribPointer () -> UnsafeMutablePointer<Void> {
		return _ptr
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
	public func setVertexAttribPointer (block: GLBufferBlock) {
		var floatSize : Int = sizeof(GLfloat)
		setVertexAttribPointer(block, pointer: _ptr.advancedBy(floatSize * block.offset))
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	:param: size The size of the attribute value per vertex in the buffer
	:param: type The data type of an element of an attribute values
	:param: normalized
	:param: stride
	:param: pointer
	*/
	public func setVertexAttribPointer (size: GLint, _ type: GLenum, _ normalized: GLboolean, _ stride: GLsizei) {
		setVertexAttribPointer(size, type, normalized, stride, _ptr)
	}
	
	
	/**
	Shortcut for glVertexAttribPointer
	
	:param: size The size of the attribute value per vertex in the buffer
	:param: type The data type of an element of an attribute values
	:param: normalized
	:param: stride
	:param: pointer
	*/
	public func setVertexAttribPointer (size: GLint, _ type: GLenum, _ normalized: GLboolean, _ stride: GLsizei, _ offset: Int) {
		setVertexAttribPointer(size, type, normalized, stride, _ptr.advancedBy(sizeof(GLfloat) * offset))
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