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
	private var _uniformvars : [String : GLUniformLocation] =
		[String : GLUniformLocation]()
	
	/// Provides the vertex attributes
	private var _attribvars : [String : GLAttribLocation] =
		[String : GLAttribLocation]()
	
	/// Contains a uniform alias to variable name map
	private var _uniformaliases : [GLUniformAlias : String] = [GLUniformAlias : String]()
	
	/// Contains a attribute alias to variable name map
	private var _attribaliases : [GLAttribAlias : String] = [GLAttribAlias : String]()
	
	/// Provides the uniform
	public var uniformvars : [GLUniformLocation] {get {return _uniformvars.values.array}}
	
	/// Provides the uniform
	public var attribvars : [GLAttribLocation] {get {return _attribvars.values.array}}
	
	/// Provides all alias set for uniforms
	public var uniformaliases : [GLUniformAlias] {get {return _uniformaliases.keys.array}}
	
	/// Provides all alias set for attributes aliases
	public var attribaliases : [GLAttribAlias] {get {return _attribaliases.keys.array}}
	
	/// Determines whether the program is valid or not
	public var valid : Bool {get {glValidateProgram(id); return iv(GL_VALIDATE_STATUS) == GL_TRUE}}
	
	/// Determines if the program is linked or not
	public var linked : Bool {get {return iv(GL_LINK_STATUS) == GL_TRUE}}
	
	/// Indicates if program is current
	public var isCurrent : Bool {get {return self == _currentProgram}}
	
	
	/** 
	Subscript acces to associated attribute alias
	
	:param: alias The GLAttribAlias
	:returns: Some GLAttribLocation object
	*/
	public subscript (alias: GLAttribAlias) -> GLAttribLocation? {
		get {
			if let varname = _attribaliases[alias] {return getAttribLocation(varname)}
			return nil
		}
	}
	
	
	/**
	Subscript acces to associated attribute alias
	
	:param: alias The GLAttribAlias
	:returns: Some GLAttribLocation object
	*/
	public subscript (alias: GLUniformAlias) -> GLUniformLocation? {
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
	public func iv (pname : Int32) -> GLint {
		var param : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		glGetProgramiv(id, GLenum(pname), param)
		return param.memory
	}
	
	
	/**
	Returns the info log
	
	:returns: The info log
	*/
	public func infoLog () -> UnsafeMutablePointer<GLchar> {
		var log : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(Int(iv(GL_INFO_LOG_LENGTH)))
		glGetProgramInfoLog(id, iv(GL_INFO_LOG_LENGTH), nil, log)
		return log
	}
	
	
	/**
	Attaches the shader to the program
	
	:param: shader The shader to attach
	*/
	public func attach (shader s: GLShader) -> GLProgram {
		glAttachShader(id, s.id)
		validateAction("attach")
		return self
	}
	
	
	/**
	Links the program and flushes all previously added attribute and
	uniform variable informations
	
	:returns:
	*/
	public func link () -> Bool {
		if linked {return true}
		
		glLinkProgram(id)
		validateAction("link")
		
		_attribvars.removeAll(keepCapacity: false)
		_uniformvars.removeAll(keepCapacity: false)

		return linked
	}
	
	
	/**
	Makes the program active
	
	:returns:
	*/
	public func use () -> Bool {
		if !linked && !link() {return false}
		if !isCurrent {
			_currentProgram = self
			glUseProgram(id)
			validateAction("use")
		}
		return true
	}
	
	/** 
	Retrieves information about an attribute variable in this shader program
	
	:param: varname the variable name in the vertex shader
	*/
	public func getAttribLocation (varname: String) -> GLAttribLocation? {
		if _attribvars[varname] != nil {return _attribvars[varname]}
		
		var location : GLint = glGetAttribLocation(id, varname)
		if location < 0 {warn("GLAttribute \(varname) not found in program."); return nil}
		
		var index : GLuint = GLuint(location)
		var bufSize : GLsizei = GLsizei(iv(GL_ACTIVE_ATTRIBUTE_MAX_LENGTH))
		var length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>.alloc(1)
		var size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		var type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>.alloc(1)
		var name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(1)
		
		glGetActiveAttrib(id, index, bufSize, length, size, type, name)
		validateAction("getAttribLocation")
		
		var attribvar : GLAttribLocation = GLAttribLocation(index: index, name: varname, type: type.memory, size: size.memory)
		_attribvars[varname] = attribvar
		return attribvar
	}
	
	/**
	Returns the attrib location by given alias
	*/
	public func getAttribLocation (alias: GLAttribAlias) -> GLAttribLocation? {
		var varname : String? = _attribaliases[alias]
		if varname == nil {return nil}
		return getAttribLocation(varname!)
	}
	
	
	/**
	Retrieves information about an uniform variable in this shader program
	
	:param: varname the variable name in the shader program
	*/
	public func getUniformLocation (varname: String) -> GLUniformLocation? {
		if _uniformvars[varname] != nil {return _uniformvars[varname]}
		
		var location : GLint = glGetUniformLocation(id, varname)
		validateAction("getUniformLocation:\(__LINE__)")
		if location < 0 {println("GLUniform \(varname) not found in program."); return nil}
		
		return getActiveUniform(location)
	}
	
	/**
	Shortcut for getUniformLocation with alias
	*/
	public func getUniformLocation (alias: GLUniformAlias) -> GLUniformLocation? {
		var varname : String? = _uniformaliases[alias]
		if varname == nil {return nil}
		return getUniformLocation(varname!)
	}
	
	
	public func getActiveUniform (location: GLint) -> GLUniformLocation {
		var index : GLuint = GLuint(location)
		var bufSize : GLsizei = GLsizei(iv(GL_ACTIVE_UNIFORM_MAX_LENGTH))
		var length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>.alloc(1)
		var size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		var type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>.alloc(1)
		var name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(1)
		
		glGetActiveUniform(id, index, bufSize, length, size, type, name)
		validateAction("getActiveUniform:\(__LINE__)")
		
		var varname : String = String.fromCString(name)!
		var uniformvar : GLUniformLocation = GLUniformLocation(index: index, name: varname, type: type.memory, size: size.memory)
		
		_uniformvars[varname] = uniformvar
		return uniformvar
	}
	
	
	/**
	Sets an attribute alias to grant access to variables in a shader without knowing the
	concrete name of it
	
	:param: alias The symbolic alias
	:param: varname The variablename
	*/
	public func setAttribAlias (alias: GLAttribAlias, _ varname: String) {
		_attribaliases[alias] = varname
	}
	
	
	/**
	Sets an uniform alias to grant access to variables in a shader without knowing the
	concrete name of it
	
	:param: alias The symbolic alias
	:param: varname The variablename
	*/
	public func setUniformAlias (alias: GLUniformAlias, _ varname: String) {
		_uniformaliases[alias] = varname
	}
	
	
	public func uniformMatrix4fv (location: GLint, _ count: Int, _ transpose: Bool, _ value: mat4) {
		glUniformMatrix4fv(location, GLsizei(count), GLboolean(transpose ? GL_TRUE : GL_FALSE), toUnsafePointer(value.array))
	}
	
	
	public func uniformMatrix4fv (uniform: GLUniformLocation, _ count: Int, _ transpose: Bool, _ value: mat4) {
		uniformMatrix4fv(GLint(uniform.id), count, transpose, value)
	}
}


extension GLProgram : Equatable {}

public func == (l: GLProgram, r: GLProgram) -> Bool {
	return l === r
}