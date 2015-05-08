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
	private var _uniformvars : [String : GLUniformLocation] = [String : GLUniformLocation]()
	
	/// Provides the vertex attributes
	private var _attribvars : [String : GLAttribLocation] = [String : GLAttribLocation]()
	
	/// Contains a uniform alias to variable name map
	private var _uniformaliasmap : [String : String] = [String : String]()
	
	/// Contains a attribute alias to variable name map
	private var _attribaliasmap : [String : String] = [String : String]()
	
	/// Provides the uniform
	public var uniformvars : [GLUniformLocation] {get {return _uniformvars.values.array}}
	
	/// Provides the uniform
	public var attribvars : [GLAttribLocation] {get {return _attribvars.values.array}}
	
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
			if let varname = _attribaliasmap[alias.rawValue] {return getAttribLocation(varname)}
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
			if let varname = _uniformaliasmap[alias.rawValue] {return getUniformLocation(varname)}
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
		
		var pointer : UnsafeMutablePointer<UnsafeMutablePointer<Void>> = UnsafeMutablePointer<UnsafeMutablePointer<Void>>.alloc(1)
		glGetVertexAttribPointerv(GLuint(location), GLenum(GL_VERTEX_ATTRIB_ARRAY_POINTER), pointer)
		
		var attribvar : GLAttribLocation = GLAttribLocation(index: GLuint(location), name: varname, pointer: pointer.memory)
		
		_attribvars[varname] = attribvar
		return attribvar
	}
	
	/**
	Returns the attrib location by given alias
	*/
	public func getAttribLocation (alias: GLAttribAlias) -> GLAttribLocation? {
		var varname : String? = _attribaliasmap[alias.rawValue]
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
		if location < 0 {println("GLUniform \(varname) not found in program."); return nil}
		
		var uniformvar : GLUniformLocation = GLUniformLocation(index: GLuint(location), name: varname)
		_uniformvars[varname] = uniformvar
		
		return uniformvar
	}
	
	/**
	Shortcut for getUniformLocation with alias
	*/
	public func getUniformLocation (alias: GLUniformAlias) -> GLUniformLocation? {
		var varname : String? = _uniformaliasmap[alias.rawValue]
		if varname == nil {return nil}
		return getUniformLocation(varname!)
	}
	
	
	/**
	Sets an attribute alias to grant access to variables in a shader without knowing the
	concrete name of it
	
	:param: alias The symbolic alias
	:param: varname The variablename
	*/
	public func setAttribAlias (alias: GLAttribAlias, _ varname: String) {
		setAttribAlias(alias.rawValue, varname)
	}
	
	
	/**
	Sets an attribute alias to grant access to variables in a shader without knowing the
	concrete name of it
	
	:param: alias The symbolic alias
	:param: varname The variablename
	*/
	public func setAttribAlias (alias: String, _ varname: String) {
		_attribaliasmap[alias] = varname
	}
	
	
	/**
	Sets an uniform alias to grant access to variables in a shader without knowing the
	concrete name of it
	
	:param: alias The symbolic alias
	:param: varname The variablename
	*/
	public func setUniformAlias (alias: GLUniformAlias, _ varname: String) {
		setUniformAlias(alias.rawValue, varname)
	}
	
	
	/**
	Sets an uniform alias to grant access to variables in a shader without knowing the
	concrete name of it
	
	:param: alias The symbolic alias
	:param: varname The variablename
	*/
	public func setUniformAlias (alias: String, _ varname: String) {
		_uniformaliasmap[alias] = varname
	}
}


extension GLProgram : Equatable {}

public func == (l: GLProgram, r: GLProgram) -> Bool {
	return l === r
}