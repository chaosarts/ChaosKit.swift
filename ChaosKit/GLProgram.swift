//
//  GLProgram.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

internal var _currentProgram : GLProgram?

public final class GLProgram: GLBase {
	
	public static private(set) var programs : [GLuint : GLProgram] = [GLuint : GLProgram]()
		
	/// Provides a list of uniforms
	private var _uniformLocations : [String : GLuniformloc] = [String : GLuniformloc]()
	
	/// Provides the vertex attributes
	private var _attribLocations : [String : GLattribloc] = [String : GLattribloc]()
	
	/// Contains a uniform alias to variable name map
	private var _uniformUrlMap : [GLurl : String] = [GLurl : String]()
	
	/// Contains a attribute alias to variable name map
	private var _attributeUrlMap : [GLurl : String] = [GLurl : String]()
	
	
	// Derived properties
	// ******************
	
	/// Determines whether the program is valid or not
	public var valid : Bool {get {glValidateProgram(id); return iv(GL_VALIDATE_STATUS) == GL_TRUE}}
	
	/// Determines if a name corresponds to a program object
	public var isProgram : Bool {get {return glIsProgram(id) == GLboolean(GL_TRUE)}}
	
	/// Determines if the program is linked or not
	public var linked : Bool {get {return iv(GL_LINK_STATUS) == GLint(GL_TRUE)}}
	
	public var deleted : Bool {get {return iv(GL_DELETE_STATUS) == GLint(GL_TRUE)}}
	
	/// Indicates if program is current
	public var isCurrent : Bool {get {return self == _currentProgram}}
	
	/// Returns the number of active uniforms
	public var activeUniforms : GLint {get {return iv(GL_ACTIVE_UNIFORMS)}}
	
	/// Returns the length of the longest active uniform variable name for program, including the null termination character
	public var activeUniformMaxLength : GLint {get {return iv(GL_ACTIVE_UNIFORM_MAX_LENGTH)}}
	
	/// Returns the number of active attribute variables for program
	public var activeAttributes : GLint {get {return iv(GL_ACTIVE_ATTRIBUTES)}}
	
	/// Returns the length of the longest active attribute name for program, including the null termination character
	public var activeAttributeMaxLength : GLint {get {return iv(GL_ACTIVE_ATTRIBUTE_MAX_LENGTH)}}
	
	/// Returns the number of shader objects attached to program
	public var attachedShaders : GLint {get {return iv(GL_ATTACHED_SHADERS)}}
	
	
	/**
	Initializes the program with given program id from glCreateProgram
	*/
	public override init (_ program: GLuint) {
		super.init(program)
		GLProgram.programs[id] = self
	}
	
	/**
	Initializes the object
	*/
	public convenience init? () {
		let id : GLuint = glCreateProgram()
		self.init(id)
		if id == 0 {
			println("Could not create program.")
			return nil
		}
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
	public func infoLog () -> String {
		let num : Int = Int(iv(GL_INFO_LOG_LENGTH))
		
		var log : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(num)
		glGetProgramInfoLog(id, iv(GL_INFO_LOG_LENGTH), nil, log)
		
		let string : String = String.fromCString(log)!
		log.dealloc(num)
		log.destroy()
		
		return string
	}
	
	/**
	Attaches a shader to this program
	
	:param: The shader object to attach
	*/
	public func attachShader (shader: GLuint) -> GLProgram {
		glAttachShader(id, shader)
		return self
	}
	
	
	/**
	Attaches one or more shaders to this program
	
	:param: shaders A list of shader objects
	:return: The program itself
 	*/
	public func attachShaders (shaders: [GLuint]) -> GLProgram {
		for shader in shaders {
			attachShader(shader)
		}
		
		return self
	}
	
	
	/**
	Attaches one or more shaders to this program
	
	:param: shaders A list of shader objects
	:return: The program itself
	*/
	public func attachShaders (shaders: GLuint...) -> GLProgram {
		return attachShaders(shaders)
	}
	
	
	/**
	Attaches the shader to the program
	
	:param: shader The shader to attach
	*/
	public func attachShader (shader: GLShader!) -> GLProgram {
		return attachShader(shader.id)
	}
	
	
	/**
	Attaches one or more shaders to this program
	
	:param: shaders The shaders to attach to this program
	*/
	public func attachShaders (shaders: [GLShader]) -> GLProgram {
		for shader in shaders {
			attachShader(shader.id)
		}
		
		return self
	}
	
	
	/**
	Attaches one or more shaders to this program
	
	:param: shaders The shaders to attach to this program
	*/
	public func attachShaders (shaders: GLShader...) -> GLProgram {
		return attachShaders(shaders)
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
		
		let log : String = infoLog()
		if count(log) > 0 {
			println(log)
		}
		
		return error
	}
	
	
	/**
	Makes the program active
	
	:returns:
	*/
	public func use () -> Bool {
		link()
		if !linked {
			warn("Cannot use program.")
			return false
		}
		
		_currentProgram = self
		glUseProgram(id)
		
		return true
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
			var attribute : GLattribloc? = getAttribLocation(block.url)
			attribute?.enable()
			attribute?.setVertexAttribPointer(block)
		}
	}
	
	
	/**
	Disable all attributes that has been used for these buffers
	
	:param: buffers The buffers to unload
	*/
	public func unload (buffers: [GLBuffer]) {
		for buffer in buffers {
			unload(buffer)
		}
	}
	
	
	/**
	Disable all attributes that has been used for this buffer
	
	:param: buffer The buffer to unload
	*/
	public func unload (buffer: GLBuffer) {
		buffer.bind()
		for block in buffer.blocks {
			var attribute : GLattribloc? = getAttribLocation(block.url)
			attribute?.disable()
		}
	}
	
	
	/** 
	Retrieves information about an attribute variable in this shader program
	
	:param: varname the variable name in the vertex shader
	:return: The attribute location object
	*/
	public func getAttribLocation (varname: String) -> GLattribloc? {
		if _attribLocations[varname] != nil {return _attribLocations[varname]}
		
		var location : GLint = glGetAttribLocation(id, varname)
		if location < 0 {warn("Attribute '\(varname)' not found in program."); return nil}
		
		var attribvar : GLattribloc = GLattribloc(index: GLuint(location), name: varname)
		
		_attribLocations[varname] = attribvar
		return attribvar
	}
	
	
	/**
	Returns the attribute location by given variable name
	
	:param: varname The varname string as it is used in the shader
	:return: The attribute location struct
	*/
	public func getAttribLocation (url: GLurl) -> GLattribloc? {
		var varname : String? = _attributeUrlMap[url]
		if varname == nil {println("Could not resolve attribute url '\(url)'.Have you set it before?"); return nil}
		return getAttribLocation(varname!)
	}
	
	
	/**
	Associates a attribute url with a varname in the shader
	
	:param: url The attribute url
	*/
	public func setAttributeUrl (url: GLurl, forLocation varname: String) {
		_attributeUrlMap[url] = varname
	}
	
	
	/**
	Retrieves information about an uniform variable in this shader program
	
	:param: varname the variable name in the shader program
	*/
	public func getUniformLocation (varname: String) -> GLuniformloc? {
		if _uniformLocations[varname] != nil {return _uniformLocations[varname]}
		
		var location : GLint = glGetUniformLocation(id, varname)
		if location < 0 {println("Uniform '\(varname)' not found in program."); return nil}
		
		var uniformvar : GLuniformloc = GLuniformloc(index: GLuint(location), name: varname)
		_uniformLocations[varname] = uniformvar
		
		return uniformvar
	}
	
	
	/**
	Returns a uniform location associated with the passed url
	
	:param: url The url, which is associated with the target uniform variable
	*/
	public func getUniformLocation (url: GLurl) -> GLuniformloc? {
		var varname : String? = _uniformUrlMap[url]
		if varname == nil {println("Could not resolve uniform url '\(url)'.Have you set it before?"); return nil}
		return getUniformLocation(varname!)
	}
	
	
	/**
	Sets a uniform url to associate with a uniform variable in this program
	
	:param: url The url vor the associated uniform variable
	:param: varname The variablename
	*/
	public func setUniformUrl (url: GLurl, forLocation varname: String) {
		_uniformUrlMap[url] = varname
	}
}


extension GLProgram : Equatable {}

public func == (l: GLProgram, r: GLProgram) -> Bool {
	return l === r
}