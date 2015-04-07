//
//  GLProgram.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

internal var _currentProgram : GLProgram?

public final class GLProgram: GLBase {
	
	/// Provides a list of uniforms
	private var _uniformvars : [String : GLUniformVariable] =
		[String : GLUniformVariable]()
	
	/// Provides the vertex attributes
	private var _attribvars : [String : GLAttribVariable] =
		[String : GLAttribVariable]()
	
	/// Contains a uniform alias to variable name map
	private var _uniformaliases : [GLUniformAlias : String] = [GLUniformAlias : String]()
	
	/// Contains a attribute alias to variable name map
	private var _attribaliases : [GLAttribAlias : String] = [GLAttribAlias : String]()
	
	/// Provides the uniform
	public var uniformvars : [GLUniformVariable] {get {return _uniformvars.values.array}}
	
	/// Provides the uniform
	public var attribvars : [GLAttribVariable] {get {return _attribvars.values.array}}
	
	/// Provides all alias set for uniform aliases
	public var uniformaliases : [GLUniformAlias] {get {return _uniformaliases.keys.array}}
	
	/// Provides all alias set for uniform aliases
	public var attribaliases : [GLAttribAlias] {get {return _attribaliases.keys.array}}
	
	/// Determines whether the program is valid or not
	public final var valid : Bool {get {glValidateProgram(id); return iv(GL_VALIDATE_STATUS) == GL_TRUE}}
	
	/// Determines if the program is linked or not
	public final var linked : Bool {get {return iv(GL_LINK_STATUS) == GL_TRUE}}
	
	/// Indicates if program is current
	public final var isCurrent : Bool {get {return self == _currentProgram}}
	
	
	/** 
	Subscript acces to associated attribute alias
	
	:param: alias The GLAttribAlias
	:returns: Some GLAttribVariable object
	*/
	public subscript (alias: GLAttribAlias) -> GLAttribVariable? {
		get {
			if let varname = _attribaliases[alias] {return getAttribLocation(varname)}
			return nil
		}
	}
	
	
	/**
	Subscript acces to associated attribute alias
	
	:param: alias The GLAttribAlias
	:returns: Some GLAttribVariable object
	*/
	public subscript (alias: GLUniformAlias) -> GLUniformVariable? {
		get {
			if let varname = _uniformaliases[alias] {return getUniformLocation(varname)}
			return nil
		}
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
	Links the program and flushes all previously added attribute and
	uniform variable informations
	
	:returns:
	*/
	public final func link () -> Bool {
		if linked {return true}
		
		glLinkProgram(id)
		_attribvars.removeAll(keepCapacity: false)
		_uniformvars.removeAll(keepCapacity: false)

		return linked
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
	Retrieves information about an attribute variable in this shader program
	
	:param: varname the variable name in the vertex shader
	*/
	public func getAttribLocation (varname: String) -> GLAttribVariable? {
		if _attribvars[varname] != nil {return _attribvars[varname]}
		
		var location : GLint = glGetAttribLocation(id, varname)
		if location < 0 {println("GLAttribute \(varname) not found in program."); return nil}
		
		var index : GLuint = GLuint(location)
		var bufSize : GLsizei = GLsizei(iv(GL_ACTIVE_ATTRIBUTE_MAX_LENGTH))
		let length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>.alloc(1)
		let size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		let type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>.alloc(1)
		let name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(1)
		
		glGetActiveAttrib(id, index, bufSize, length, size, type, name)
		
		var attribvar : GLAttribVariable = GLAttribVariable(index: index, name: varname, type: type.memory, size: size.memory)
		_attribvars[varname] = attribvar
		return attribvar
	}
	
	
	/**
	Retrieves information about an uniform variable in this shader program
	
	:param: varname the variable name in the shader program
	*/
	public func getUniformLocation (varname: String) -> GLUniformVariable? {
		if _uniformvars[varname] != nil {return _uniformvars[varname]}
		
		var location : GLint = glGetUniformLocation(id, varname)
		if location < 0 {println("GLUniform \(varname) not found in program."); return nil}
		
		var index : GLuint = GLuint(location)
		var bufSize : GLsizei = GLsizei(iv(GL_ACTIVE_UNIFORM_MAX_LENGTH))
		var length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>.alloc(1)
		var size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		var type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>.alloc(1)
		var name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(1)
		
		glGetActiveUniform(id, index, bufSize, length, size, type, name)
		
		var uniformvar : GLUniformVariable = GLUniformVariable(index: index, name: varname, type: type.memory, size: size.memory)
		_uniformvars[varname] = uniformvar
		return uniformvar
	}
	
	
	/**
	Sets an attribute alias to grant access to variables in a shader without knowing the
	concrete name of it
	
	:param: alias The symbolic alias
	:param: varname The variablename
	*/
	public func setAttribAlias (alias: GLAttribAlias, varname: String) {
		_attribaliases[alias] = varname
	}
	
	
	/**
	Sets an uniform alias to grant access to variables in a shader without knowing the
	concrete name of it
	
	:param: alias The symbolic alias
	:param: varname The variablename
	*/
	public func setUniformAlias (alias: GLUniformAlias, varname: String) {
		_uniformaliases[alias] = varname
	}
}


extension GLProgram : Equatable {}

public func == (l: GLProgram, r: GLProgram) -> Bool {
	return l === r
}