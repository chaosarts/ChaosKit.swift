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
	private var _uniformLocations : [String : GLUniformLocation] = [String : GLUniformLocation]()
	
	/// Provides the vertex attributes
	private var _attribLocations : [String : GLAttribLocation] = [String : GLAttribLocation]()
	
	/// Contains a uniform alias to variable name map
	private var _uniformSelectors : [String : String] = [String : String]()
	
	/// Contains a attribute alias to variable name map
	private var _attributeSelectors : [GLAttributeSelector : String] = [GLAttributeSelector : String]()
	
	
	// Derived properties
	// ******************
	
	/// Determines whether the program is valid or not
	public var valid : Bool {get {glValidateProgram(id); return iv(GL_VALIDATE_STATUS) == GL_TRUE}}
	
	/// Determines if the program is linked or not
	public var linked : Bool {get {return iv(GL_LINK_STATUS) == GLint(GL_TRUE)}}
	
	public var deleted : Bool {get {return iv(GL_DELETE_STATUS) == GLint(GL_TRUE)}}
	
	/// Indicates if program is current
	public var isCurrent : Bool {get {return self == _currentProgram}}
	
	
	/**
	Initializes the object
	*/
	public init () {
		super.init(glCreateProgram())
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
		return self
	}
	
	
	/**
	Links the program and flushes all previously added attribute and
	uniform variable informations
	
	:returns:
	*/
	public func link () -> GLenum {
		if linked {return GLenum(GL_NO_ERROR)}
		
		glLinkProgram(id)
		_attribLocations.removeAll()
		_uniformLocations.removeAll()

		var error : GLenum = glGetError()
		
		if error != GLenum(GL_NO_ERROR) {
			warn("Program could not be linked. Did you make OpenGL context current?")
		}
		return error
	}
	
	
	/**
	Makes the program active
	
	:returns:
	*/
	public func use () -> GLProgram {
		link()
		if !linked {
			warn("Cannot use program.")
			return self
		}
		
		_currentProgram = self
		glUseProgram(id)
		
		return self
	}
	
	
	/**
	Uploads buffer data to opengl
	
	:param: buffers The buffers to upload
	*/
	public func upload (buffers: [GLBuffer]) {
		for buffer in buffers {
			upload(buffer)
		}
	}
	
	
	/**
	Uploads data buffer to opengl
	
	:param: buffer The buffer to upload
	*/
	public func upload (buffer: GLBuffer) {
		buffer.bind()
		for block in buffer.blocks {
			var attribute : GLAttribLocation? = getAttribLocation(block.selector)
			attribute?.enable()
			attribute?.setVertexAttribPointer(block)
		}
	}
	
	
	/** 
	Retrieves information about an attribute variable in this shader program
	
	:param: varname the variable name in the vertex shader
	:return: The attribute location object
	*/
	public func getAttribLocation (varname: String) -> GLAttribLocation? {
		if _attribLocations[varname] != nil {return _attribLocations[varname]}
		
		var location : GLint = glGetAttribLocation(id, varname)
		if location < 0 {warn("GLAttribData \(varname) not found in program."); return nil}
		
		var pointer : UnsafeMutablePointer<UnsafeMutablePointer<Void>> = UnsafeMutablePointer<UnsafeMutablePointer<Void>>.alloc(1)
		glGetVertexAttribPointerv(GLuint(location), GLenum(GL_VERTEX_ATTRIB_ARRAY_POINTER), pointer)
		
		var attribvar : GLAttribLocation = GLAttribLocation(index: GLuint(location), name: varname, pointer: pointer.memory)
		
		_attribLocations[varname] = attribvar
		return attribvar
	}
	
	
	/**
	Returns the attribute location by given variable name
	
	:param: varname The varname string as it is used in the shader
	:return: The attribute location struct
	*/
	public func getAttribLocation (selector: GLAttributeSelector) -> GLAttribLocation? {
		var varname : String? = _attributeSelectors[selector]
		if varname == nil {return nil}
		return getAttribLocation(varname!)
	}
	
	
	/**
	Associates a attribute selector with a varname in the shader
	
	:param: selector The attribute selector
	*/
	public func setAttributeSelector (selector: GLAttributeSelector, forLocation varname: String) {
		_attributeSelectors[selector] = varname
	}
	
	
	/**
	Retrieves information about an uniform variable in this shader program
	
	:param: varname the variable name in the shader program
	*/
	public func getUniformLocation (varname: String) -> GLUniformLocation? {
		if _uniformLocations[varname] != nil {return _uniformLocations[varname]}
		
		var location : GLint = glGetUniformLocation(id, varname)
		if location < 0 {println("GLUniform \(varname) not found in program."); return nil}
		
		var uniformvar : GLUniformLocation = GLUniformLocation(index: GLuint(location), name: varname)
		_uniformLocations[varname] = uniformvar
		
		return uniformvar
	}
	
	
	/**
	Shortcut for getUniformLocation with alias
	*/
	public func getUniformLocation (alias: GLUniformAlias) -> GLUniformLocation? {
		var varname : String? = _uniformSelectors[alias.rawValue]
		if varname == nil {return nil}
		return getUniformLocation(varname!)
	}
	
	
	/**
	Shortcut for getUniformLocation with alias
	*/
	public func getUniformLocation (alias: GLTextureMapType) -> GLUniformLocation? {
		var varname : String? = _uniformSelectors[alias.rawValue]
		if varname == nil {return nil}
		return getUniformLocation(varname!)
	}
	
	
	/**
	Sets an uniform alias to grant access to variables in a shader without knowing the
	concrete name of it
	
	:param: alias The symbolic alias
	:param: varname The variablename
	*/
	public func setUniformAlias (alias: String, _ varname: String) {
		_uniformSelectors[alias] = varname
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
	public func setUniformAlias (alias: GLTextureMapType, _ varname: String) {
		setUniformAlias(alias.rawValue, varname)
	}
}


extension GLProgram : Equatable {}

public func == (l: GLProgram, r: GLProgram) -> Bool {
	return l === r
}