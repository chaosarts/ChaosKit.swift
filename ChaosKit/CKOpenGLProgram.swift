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
	public final var uniforms : [CKOpenGLBaseUniformType : CKOpenGLUniform] = [CKOpenGLBaseUniformType : CKOpenGLUniform]()
	
	/** Provides the vertex attributes */
	public final var attributes : [CKOpenGLBaseAttributeType : CKOpenGLAttribute] = [CKOpenGLBaseAttributeType : CKOpenGLAttribute]()
	
	// UNIFORM SHORTCUTS 
	// *****************
	
	/** Shortcut for modelview matrix */
	public final var uniformModelMatrix : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.ModelViewMatrix]!}
		set {uniforms[CKOpenGLBaseUniformType.ModelViewMatrix] = newValue}
	}
	
	/** Shortcut for projection matrix */
	public final var uniformProjectionMatrix : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.ProjectionViewMatrix]!}
		set {uniforms[CKOpenGLBaseUniformType.ProjectionViewMatrix] = newValue}
	}
	
	/** Shortcut for ambient light color uniform */
	public final var uniformAmbientLightColor : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.AmbientLightColor]!}
		set {uniforms[CKOpenGLBaseUniformType.AmbientLightColor] = newValue}
	}
	
	/** Shortcut for ambient light intensity uniform */
	public final var uniformAmbientLightIntensity : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.AmbientLightIntensity]!}
		set {uniforms[CKOpenGLBaseUniformType.AmbientLightIntensity] = newValue}
	}
	
	/** Shortcut for diffuse light color uniform */
	public final var uniformDiffuseLightColor : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.DiffuseLightColor]!}
		set {uniforms[CKOpenGLBaseUniformType.DiffuseLightColor] = newValue}
	}
	
	/** Shortcut for diffuse light intensity uniform */
	public final var uniformDiffuseLightIntensity : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.DiffuseLightIntensity]!}
		set {uniforms[CKOpenGLBaseUniformType.DiffuseLightIntensity] = newValue}
	}
	
	/** Shortcut for diffuse light position uniform */
	public final var uniformDiffuseLightPosition : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.DiffuseLightPosition]!}
		set {uniforms[CKOpenGLBaseUniformType.DiffuseLightPosition] = newValue}
	}
	
	/** Shortcut for specular light color uniform */
	public final var uniformSpecularLightColor : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.SpecularLightColor]!}
		set {uniforms[CKOpenGLBaseUniformType.SpecularLightColor] = newValue}
	}
	
	/** Shortcut for specular light intensity uniform */
	public final var uniformSpecularLightIntensity : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.SpecularLightIntensity]!}
		set {uniforms[CKOpenGLBaseUniformType.SpecularLightIntensity] = newValue}
	}
	
	/** Shortcut for specular light position uniform */
	public final var uniformSpecularLightPosition : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.SpecularLightPosition]!}
		set {uniforms[CKOpenGLBaseUniformType.SpecularLightPosition] = newValue}
	}
	
	/** Shortcut for specular light position uniform */
	public final var uniformSpecularLightShininess : CKOpenGLUniform {
		get {return uniforms[CKOpenGLBaseUniformType.SpecularLightShininess]!}
		set {uniforms[CKOpenGLBaseUniformType.SpecularLightShininess] = newValue}
	}
	
	
	// ATTRIBUTE SHORTCUTS
	// *******************
	
	/** Shortcut to access position attriubute */
	public final var attributeVertexPosition : CKOpenGLAttribute {
		get {return attributes[CKOpenGLBaseAttributeType.Position]!}
		set {attributes[CKOpenGLBaseAttributeType.Position] = newValue}
	}
	
	/** Shortcut to access normal attriubute */
	public final var attributeVertexNormal : CKOpenGLAttribute {
		get {return attributes[CKOpenGLBaseAttributeType.Normal]!}
		set {attributes[CKOpenGLBaseAttributeType.Normal] = newValue}
	}
	
	/** Shortcut to access color attriubute */
	public final var attributeVertexColor : CKOpenGLAttribute {
		get {return attributes[CKOpenGLBaseAttributeType.Color]!}
		set {attributes[CKOpenGLBaseAttributeType.Color] = newValue}
	}
	
	/** Shortcut to access tex coord attriubute */
	public final var attributeVertexTexCoord : CKOpenGLAttribute {
		get {return attributes[CKOpenGLBaseAttributeType.TexCoord]!}
		set {attributes[CKOpenGLBaseAttributeType.TexCoord] = newValue}
	}
	
	
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
		
		uniformModelMatrix = CKOpenGLUniform(name: "uModelViewMatrix")
		uniformProjectionMatrix = CKOpenGLUniform(name: "uProjectionMatrix")
		
		uniformAmbientLightColor = CKOpenGLUniform(name: "uAmbientLightColor")
		uniformAmbientLightIntensity = CKOpenGLUniform(name: "uAmbientLightIntensity")
		
		uniformDiffuseLightColor = CKOpenGLUniform(name: "uDiffuseLightColor")
		uniformDiffuseLightIntensity = CKOpenGLUniform(name: "uDiffuseLightIntensity")
		uniformDiffuseLightPosition = CKOpenGLUniform(name: "uDiffuseLightPosition")
		
		uniformSpecularLightColor = CKOpenGLUniform(name: "uSpecularLightColor")
		uniformSpecularLightIntensity = CKOpenGLUniform(name: "uSpecularLightIntensity")
		uniformSpecularLightPosition = CKOpenGLUniform(name: "uSpecularLightPosition")
		
		attributeVertexPosition = CKOpenGLAttribute(name: "aVertexPosition",
			target: CKOpenGLTargetAttribute.Position)
		attributeVertexNormal = CKOpenGLAttribute(name: "aVertexNormal",
			target: CKOpenGLTargetAttribute.Normal)
		attributeVertexColor = CKOpenGLAttribute(name: "aVertexColor",
			target: CKOpenGLTargetAttribute.Color)
		attributeVertexTexCoord = CKOpenGLAttribute(name: "aVertexTexCoord",
			target: CKOpenGLTargetAttribute.TexCoord)
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
		getActiveLocations()
		if !linked {
			print(String.fromCString(infoLog())!)
			return false
		}
		
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
	
	
	public func getActiveLocations () {
		getActiveUniform(&uniformProjectionMatrix)
		getActiveUniform(&uniformModelMatrix)
		
		getActiveUniform(&uniformAmbientLightColor)
		getActiveUniform(&uniformAmbientLightIntensity)
		
		getActiveUniform(&uniformDiffuseLightColor)
		getActiveUniform(&uniformDiffuseLightIntensity)
		getActiveUniform(&uniformDiffuseLightPosition)
		
		getActiveUniform(&uniformSpecularLightColor)
		getActiveUniform(&uniformSpecularLightIntensity)
		getActiveUniform(&uniformSpecularLightPosition)
		
		getActiveAttribute(&attributeVertexPosition)
		getActiveAttribute(&attributeVertexColor)
		getActiveAttribute(&attributeVertexNormal)
		getActiveAttribute(&attributeVertexTexCoord)
	}
	
	/** 
	Fills the passed uniform with information about type size etc 
	
	:param: uniform
	:returns: True when the unform has been located in the program, otherwise false
	*/
	public func getActiveUniform (inout uniform: CKOpenGLUniform) -> Bool {
		var location : GLint = glGetUniformLocation(id, uniform.name)
		if location < 0 {println("Uniform \(uniform.name) not found in program."); return false}
		
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
		
		return true
	}
	
	
	/**
	Fills the attribute object with the information about the attribute in the sahder program
	
	:param: attribute
	:returns: True when attribute has been located in the program, false otherwise
	*/
	public func getActiveAttribute (inout attribute: CKOpenGLAttribute) -> Bool {
		var location : GLint = glGetAttribLocation(id, attribute.name)
		if location < 0 {println("Attribute \(attribute.name) not found"); return false}
		
		var length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>.alloc(1)
		var size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		var type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>.alloc(1)
		var name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(1)
		
		glGetActiveAttrib(id, GLuint(location), iv(GL_ACTIVE_ATTRIBUTE_MAX_LENGTH).memory, length, size, type, name)
		
		attribute.location = location
		attribute.type = type.memory
		attribute.size = size.memory
		
		return true
	}
	
	
	public func enableAttributes (view: CKOpenGLView) {
		
	}
	
	
	public func bindVertexAttribute (type: CKOpenGLBaseAttributeType, vecsize: Int = 3, stride: Int = 0) {
		var attribute : CKOpenGLAttribute? = attributes[type]
		if nil == attribute || attribute!.location < 0 {return}
		
		var location : GLuint = GLuint(attribute!.location)
		var pointer : UnsafeMutablePointer<UnsafeMutablePointer<Void>> = UnsafeMutablePointer<UnsafeMutablePointer<Void>>.alloc(1)
		
		glGetVertexAttribPointerv(location, GLenum(GL_VERTEX_ATTRIB_ARRAY_POINTER), pointer)
		glVertexAttribPointer(location, GLint(vecsize), GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(stride), pointer.memory)
		glEnableVertexAttribArray(location)
	}
}


public enum CKOpenGLBaseAttributeType : String {
	case Position = "Position"
	case Normal = "Normal"
	case Color = "Color"
	case TexCoord = "TexCoord"
}


public enum CKOpenGLBaseUniformType : String {
	case ModelViewMatrix = "ModelViewMatrix"
	case ProjectionViewMatrix = "ProjectionViewMatrix"
	
	case AmbientLightColor = "AmbientLightColor"
	case AmbientLightIntensity = "AmbientLightIntensity"
	
	case DiffuseLightColor = "DiffuseLightColor"
	case DiffuseLightPosition = "DiffuseLightPosition"
	case DiffuseLightIntensity = "DiffuseLightIntensity"
	
	case SpecularLightColor = "SpecularLightColor"
	case SpecularLightPosition = "SpecularLightPosition"
	case SpecularLightIntensity = "SpecularLightIntensity"
	case SpecularLightShininess = "SpecularLightShininess"
}