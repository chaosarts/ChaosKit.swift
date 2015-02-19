//
//  CKOpenGLProgram.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLProgram: CKOpenGLBase {
	
	/** Provides a list of uniforms */
	private final var _uniforms : [CKOpenGLUniformType : CKOpenGLUniformInfo] =
		[CKOpenGLUniformType : CKOpenGLUniformInfo]()
	
	/** Provides the vertex attributes */
	private final var _attributes : [CKOpenGLAttributeType : CKOpenGLAttributeInfo] =
		[CKOpenGLAttributeType : CKOpenGLAttributeInfo]()
	
	
	// PROGRAM STATUS
	// **************
	
	/** Determines whether the program is valid or not */
	public final var valid : Bool {
		get {glValidateProgram(id); return iv(GL_VALIDATE_STATUS).memory == GL_TRUE}
	}
	
	
	/** Determines if the program is linked or not */
	public final var linked : Bool {
		get {return iv(GL_LINK_STATUS).memory == GL_TRUE}
	}
	
	
	/**
	Initializes the object
	*/
	public init () {
		var id = glCreateProgram()
		super.init(id: id)
	}
	
	
	/**
	Short cut for glGetProgramiv(pname: GLenum)
	
	:param: pname The paramater name to fetch the value
	*/
	final public func iv (pname : Int32) -> UnsafeMutablePointer<GLint> {
		var param : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		glGetProgramiv(id, GLenum(pname), param)
		return param
	}
	
	
	/**
	Returns the info log
	
	:returns: The info log
	*/
	final public func infoLog () -> UnsafeMutablePointer<GLchar> {
		var log : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(Int(iv(GL_INFO_LOG_LENGTH).memory))
		glGetProgramInfoLog(id, iv(GL_INFO_LOG_LENGTH).memory, nil, log)
		return log
	}
	
	
	/**
	Attaches the shader to the program
	
	:param: shader The shader to attach
	*/
	final public func attach (shader s: CKOpenGLShader) -> CKOpenGLProgram {
		glAttachShader(id, s.id)
		return self
	}
	
	
	/**
	Links the program
	*/
	final public func link () -> Bool {
		glLinkProgram(id)
		if !linked {
			print(String.fromCString(infoLog())!)
			return false
		}
		
		updateAttributeInfos()
		return true
	}
	
	
	/**
	Makes the program active
	
	:returns:
	*/
	final public func use () -> Bool {
		if !linked && !link() {return false}
		glUseProgram(id)
		return true
	}
	
	
	public func bindVertexAttribute (type: CKOpenGLAttributeType, vecsize: Int = 3, stride: Int = 0) {
		var attribute : CKOpenGLAttributeInfo? = _attributes[type]
		if nil == attribute || attribute!.location < 0 {return}
		
		var location : GLuint = GLuint(attribute!.location)
		var pointer : UnsafeMutablePointer<UnsafeMutablePointer<Void>> = UnsafeMutablePointer<UnsafeMutablePointer<Void>>.alloc(1)
		
		glGetVertexAttribPointerv(location, GLenum(GL_VERTEX_ATTRIB_ARRAY_POINTER), pointer)
		glVertexAttribPointer(location, GLint(vecsize), GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(stride), pointer.memory)
		glEnableVertexAttribArray(location)
	}
	
	
	/** 
	Adds a new attribute info object to indicate the according attribute
	to be present in the program. The informations will be deteced 
	automatically, when program has been linked otherwise, when link()
	is called
	
	:param: attributeInfo
	*/
	public func addAttributeInfo (attributeInfo: CKOpenGLAttributeInfo) {
		_attributes[attributeInfo.target] = attributeInfo
		if linked {updateAttributeInfo(&_attributes[attributeInfo.target]!)}
	}
	
	
	/**
	Adds a new uniform info object to indicate the according attribute
	to be present in the program. The informations will be deteced
	automatically, when program has been linked otherwise, when link()
	is called
	
	:param: attributeInfo
	*/
	public func addUniformInfo (uniformInfo: CKOpenGLUniformInfo) {
		_uniforms[uniformInfo.target] = uniformInfo
		if linked {updateUniformInfo(&_uniforms[uniformInfo.target]!)}
	}
	
	
	/**
	Returns the uniform info object
	
	:param: forType
	:returns: Some uniform info object
	*/
	public func getAttributeInfo (forType type: CKOpenGLAttributeType) -> CKOpenGLAttributeInfo? {
		return _attributes[type]
	}
	
	
	/**
	Returns the uniform info object
	
	:param: forType
	:returns: Some uniform info object
 	*/
	public func getUniformInfo (forType type: CKOpenGLUniformType) -> CKOpenGLUniformInfo? {
		return _uniforms[type]
	}
	
	
	/**
	Updates information about all attribute info objects that has been added to 
	this program
	*/
	private func updateAttributeInfos () {
		if _attributes.count == 0 {
			warn("No attribute locations added to program.")
			return
		}
		
		for key in _attributes.keys {
			updateAttributeInfo(&_attributes[key]!)
		}
	}
	
	
	/**
	Updates a attribute info object
	*/
	private func updateAttributeInfo (inout attribute: CKOpenGLAttributeInfo) {
		attribute.location = glGetAttribLocation(id, attribute.name)
		
		if attribute.location < 0 {
			warn("Attribute location with name '\(attribute.name)' not found.")
			return
		}
		
		var bufSize : GLsizei = GLsizei(iv(GL_ACTIVE_ATTRIBUTE_MAX_LENGTH).memory)
		
		let length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>.alloc(1)
		let size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		let type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>.alloc(1)
		let name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(1)
		
		glGetActiveAttrib(id, GLuint(attribute.location), bufSize, length, size, type, name)
		
		attribute.size = size.memory
		attribute.type = type.memory
		
		if attribute.size <= 1 {return}
		
		attribute.locations = []
		
		for i in 0..<Int(attribute.size!) {
			var location : GLint = glGetAttribLocation(id, "\(attribute.name)[\(i)]")
			
			if location < 0 {continue}
			
			attribute.locations.append(GLuint(location))
		}
	}
	
	
	/**
	Updates information about all uniforms info objects that has been added to
	this program
	*/
	private func updateUniformInfos () {
		if _uniforms.count == 0 {
			warn("No uniform locations added to program.")
			return
		}
		
		for key in _uniforms.keys {
			updateUniformInfo(&_uniforms[key]!)
		}
	}
	
	
	/**
	Fills the passed uniform with information about type size etc
	
	:param: uniform
	:returns: True when the unform has been located in the program, otherwise false
	*/
	private func updateUniformInfo (inout uniform: CKOpenGLUniformInfo) {
		var location : GLint = glGetUniformLocation(id, uniform.name)
		if location < 0 {println("Uniform \(uniform.name) not found in program."); return}
		
		var length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>.alloc(1)
		var size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		var type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>.alloc(1)
		var name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(1)
		
		glGetActiveUniform(id, GLuint(location), iv(GL_ACTIVE_UNIFORM_MAX_LENGTH).memory, length, size, type, name)
		
		uniform.location = location
		uniform.type = type.memory
		uniform.size = size.memory
		
		for i in 0..<Int(uniform.size!) {
			glGetUniformLocation(id, uniform.name + "[\(i)]")
		}
	}
}