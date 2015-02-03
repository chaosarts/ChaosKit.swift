//
//  CKOpenGLProgram.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

final public class CKOpenGLProgram: CKOpenGLBase {
	
	/** Provides a list of attributes associated with their names */
	internal var _attributes : [String : CKOpenGLAttribute] = Dictionary()
	
	/** Provides a list of attributes associated with their names */
	public var attributes : [String : CKOpenGLAttribute] {
		get {return _attributes}
	}
	
	/** Determines whether the program is valid or not */
	public var valid : Bool {
		get {glValidateProgram(id); return iv(GL_VALIDATE_STATUS) == GL_TRUE}
	}
	
	/** Determines if the program is linked or not */
	public var linked : Bool {
		get {return iv(GL_LINK_STATUS) == GL_TRUE}
	}
	
	
	/**
	Initializes the object 
	*/
	public init () {
		super.init(id: glCreateProgram())
	}
	
	
	/**
	Short cut for glGetProgramiv(pname: GLenum)
	
	:param: pname The paramater name to fetch the value
	*/
	public func iv (pname : Int32) -> GLint {
		var param : GLint = GLint()
		glGetProgramiv(id, GLenum(pname), &param)
		return param
	}
	
	
	/** 
	Returns the info log
	
	:returns: The info log
	*/
	public func infoLog () -> [GLchar] {
		var log : [GLchar] = []
		glGetProgramInfoLog(id, iv(GL_INFO_LOG_LENGTH), nil, &log)
		return log
	}
	
	
	/** 
	Attaches the shader to the program
	
	:param: shader The shader to attach
	*/
	public func attach (shader s: CKOpenGLShader) -> CKOpenGLProgram {
		glAttachShader(id, s.id)
		return self
	}
	
	
	/** 
	Links the program
	*/
	public func link () -> Bool {
		_attributes.removeAll(keepCapacity: false)
		glLinkProgram(id)
		
		if !linked {
			print(String.fromCString(infoLog())!)
			return false
		}
		
		return true
	}
	
	
	/** 
	Makes the program active
	*/
	public func use () -> Bool {
		if !linked && !link() {return false}
		glUseProgram(id)
		scan()
		return true
	}
	
	
	/** 
	Shortcut for
	*/
	public func getAttribLocation (name: String) -> CKOpenGLAttribute? {
		var attribute = _attributes[name]
		return attribute
	}
	
	
	/** 
	
	*/
	private func scan () -> Bool {
		if !linked {
			return false
		}
		
		var maxAttribIndex : Int = Int(iv(GL_ACTIVE_ATTRIBUTES))
		
		for i in 0...maxAttribIndex {
			var attribute : CKOpenGLAttribute = getActiveAttrib(GLuint(i))
			_attributes[attribute.name] = attribute
		}
		
		return true
	}
	
	
	private func getActiveAttrib (index: GLuint) -> CKOpenGLAttribute {
		var maxAttribLen : GLint = iv(GL_ACTIVE_ATTRIBUTE_MAX_LENGTH)
		
		var length : GLsizei = GLsizei()
		var size : GLint = GLint()
		var type : GLenum = GLenum()
		var name : GLchar = GLchar()
		glGetActiveAttrib(id, index, maxAttribLen, &length, &size, &type, &name)
		
		var attribute : CKOpenGLAttribute = CKOpenGLAttribute(index: index, name: String.fromCString(&name)!, type: type, size: size, length: length)
		
		return attribute
	}
}
