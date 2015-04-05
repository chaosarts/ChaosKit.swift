//
//  GLProgram.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

internal var _currentProgram : GLProgram?

public class GLProgram: GLBase {
	
	/** Provides a list of uniforms */
	private final var _uniforms : [GLUniformType : GLUniformInfo] =
		[GLUniformType : GLUniformInfo]()
	
	/** Provides the vertex attributes */
	private final var _attributes : [GLAttributeTarget : GLAttributeInfo] =
		[GLAttributeTarget : GLAttributeInfo]()
	
	/** Determines whether the program is valid or not */
	public final var valid : Bool {get {glValidateProgram(id); return iv(GL_VALIDATE_STATUS) == GL_TRUE}}
	
	/** Determines if the program is linked or not */
	public final var linked : Bool {get {return iv(GL_LINK_STATUS) == GL_TRUE}}
	
	/** Indicates if program is current */
	public final var isCurrent : Bool {get {return self == _currentProgram}}
	
	
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
	public final func iv (pname : Int32) -> GLint {
		if _ivCache[pname] == nil {
			var param : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
			glGetProgramiv(id, GLenum(pname), param)
			_ivCache[pname] = param.memory
		}
		return _ivCache[pname]!
	}
	
	
	/**
	Returns the info log
	
	:returns: The info log
	*/
	public final func infoLog () -> UnsafeMutablePointer<GLchar> {
		var log : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(Int(iv(GL_INFO_LOG_LENGTH)))
		glGetProgramInfoLog(id, iv(GL_INFO_LOG_LENGTH), nil, log)
		return log
	}
	
	
	/**
	Attaches the shader to the program
	
	:param: shader The shader to attach
	*/
	public final func attach (shader s: GLShader) -> GLProgram {
		glAttachShader(id, s.id)
		return self
	}
	
	
	/**
	Links the program
	
	:returns:
	*/
	public final func link () -> Bool {
		glLinkProgram(id)
		_ivCache.removeAll(keepCapacity: true)
		if !linked {
			print(String.fromCString(infoLog())!)
			return false
		}
		
		updateAttributeInfos()
		updateUniformInfos()
		return true
	}
	
	
	/**
	Makes the program active
	
	:returns:
	*/
	public final func use () -> Bool {
		if !linked && !link() {return false}
		if !isCurrent {
			_currentProgram = self
			glUseProgram(id)
		}
		return true
	}
	
	/** 
	Adds a new attribute info object to indicate the according attribute
	to be present in the program. The informations will be deteced 
	automatically, when program has been linked otherwise, when link()
	is called
	
	:param: GLAttributeInfo
	*/
	public func addAttributeInfo (attributeInfo: GLAttributeInfo) {
		_attributes[attributeInfo.target] = attributeInfo
		if linked {
			updateAttributeInfo(&_attributes[attributeInfo.target]!)
		}
	}
	
	
	/**
	Adds a new uniform info object to indicate the according attribute
	to be present in the program. The informations will be deteced
	automatically, when program has been linked otherwise, when link()
	is called
	
	:param: GLAttributeInfo
	*/
	public func addUniformInfo (uniformInfo: GLUniformInfo) {
		_uniforms[uniformInfo.target] = uniformInfo
		if linked {
			updateUniformInfo(&_uniforms[uniformInfo.target]!)
		}
	}
	
	
	/**
	Returns the uniform info object
	
	:param: forType
	:returns: Some uniform info object
	*/
	public func getAttributeInfo (forType type: GLAttributeTarget) -> GLAttributeInfo? {
		return _attributes[type]
	}
	
	
	/**
	Returns the uniform info object
	
	:param: forType
	:returns: Some uniform info object
 	*/
	public func getUniformInfo (forType type: GLUniformType) -> GLUniformInfo? {
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
	private func updateAttributeInfo (inout attribute: GLAttributeInfo) {
		attribute.location = glGetAttribLocation(id, attribute.name)
		
		if attribute.location < 0 {
			warn("Attribute location with name '\(attribute.name)' not found.")
			return
		}
		
		var bufSize : GLsizei = GLsizei(iv(GL_ACTIVE_ATTRIBUTE_MAX_LENGTH))
		
		let length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>.alloc(1)
		let size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		let type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>.alloc(1)
		let name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(1)
		
		glGetActiveAttrib(id, GLuint(attribute.location), bufSize, length, size, type, name)
		
		attribute.size = size.memory
		attribute.type = type.memory
		
		
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
	private func updateUniformInfo (inout uniform: GLUniformInfo) {
		var location : GLint = glGetUniformLocation(id, uniform.name)
		if location < 0 {println("GLUniform \(uniform.name) not found in program."); return}
		
		var length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>.alloc(1)
		var size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		var type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>.alloc(1)
		var name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(1)
		
		glGetActiveUniform(id, GLuint(location), iv(GL_ACTIVE_UNIFORM_MAX_LENGTH), length, size, type, name)
		
		uniform.location = location
		uniform.type = type.memory
		uniform.size = size.memory
		uniform.locations = []
		
		for i in 0..<Int(uniform.size!) {
			uniform.locations.append(glGetUniformLocation(id, uniform.name + "[\(i)]"))
		}
	}
}


extension GLProgram : Equatable {}

public func == (l: GLProgram, r: GLProgram) -> Bool {
	return l === r
}