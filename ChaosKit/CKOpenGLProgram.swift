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
	public var baseUniforms : [CKOpenGLBaseUniformType : CKOpenGLUniform] = [CKOpenGLBaseUniformType : CKOpenGLUniform]()
	
	/** Shortcut for modelview matrix */
	public var uniformModelMatrix : CKOpenGLUniform {
		get {return baseUniforms[CKOpenGLBaseUniformType.ModelViewMatrix]!}
		set {baseUniforms[CKOpenGLBaseUniformType.ModelViewMatrix] = newValue}
	}
	
	/** Shortcut for projection matrix */
	public var uniformProjectionMatrix : CKOpenGLUniform {
		get {return baseUniforms[CKOpenGLBaseUniformType.ProjectionViewMatrix]!}
		set {baseUniforms[CKOpenGLBaseUniformType.ProjectionViewMatrix] = newValue}
	}
	
	/** Provides the vertex attributes */
	public var baseAttributes : [CKOpenGLBaseAttributeType : CKOpenGLAttribute] = [CKOpenGLBaseAttributeType : CKOpenGLAttribute]()
	
	/** Shortcut to access position attriubute */
	public var vertexAttributePosition : CKOpenGLAttribute {
		get {return baseAttributes[CKOpenGLBaseAttributeType.Position]!}
		set {baseAttributes[CKOpenGLBaseAttributeType.Position] = newValue}
	}
	
	/** Shortcut to access normal attriubute */
	public var vertexAttributeNormal : CKOpenGLAttribute {
		get {return baseAttributes[CKOpenGLBaseAttributeType.Normal]!}
		set {baseAttributes[CKOpenGLBaseAttributeType.Normal] = newValue}
	}
	
	/** Shortcut to access color attriubute */
	public var vertexAttributeColor : CKOpenGLAttribute {
		get {return baseAttributes[CKOpenGLBaseAttributeType.Color]!}
		set {baseAttributes[CKOpenGLBaseAttributeType.Color] = newValue}
	}
	
	/** Shortcut to access tex coord attriubute */
	public var vertexAttributeTexCoord : CKOpenGLAttribute {
		get {return baseAttributes[CKOpenGLBaseAttributeType.TexCoord]!}
		set {baseAttributes[CKOpenGLBaseAttributeType.TexCoord] = newValue}
	}
	
	/** Determines whether the program is valid or not */
	public var valid : Bool {
		get {glValidateProgram(id); return iv(GL_VALIDATE_STATUS).memory == GL_TRUE}
	}
	
	/** Determines if the program is linked or not */
	public var linked : Bool {
		get {return iv(GL_LINK_STATUS).memory == GL_TRUE}
	}
	
	/**
	Initializes the object
	*/
	public init () {
		var id = glCreateProgram()
		super.init(id: id)
		
		uniformModelMatrix = CKOpenGLUniform(name: "uModelViewMatrix", type: GL_FLOAT_MAT4)
		uniformProjectionMatrix = CKOpenGLUniform(name: "uProjectionMatrix", type: GL_FLOAT_MAT4)
		
		vertexAttributePosition = CKOpenGLAttribute(name: "aVertexPosition", type: GL_FLOAT_VEC3)
		vertexAttributeNormal = CKOpenGLAttribute(name: "aVertexNormal", type: GL_FLOAT_VEC3)
		vertexAttributeColor = CKOpenGLAttribute(name: "aVertexColor", type: GL_FLOAT_VEC3)
		vertexAttributeTexCoord = CKOpenGLAttribute(name: "aVertexTexCoord", type: GL_FLOAT_VEC3)
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
		
		uniformProjectionMatrix.location = glGetUniformLocation(id, uniformProjectionMatrix.name)
		if uniformProjectionMatrix.location < 0 {
			println("Uniform location \(uniformProjectionMatrix.name) not found")
		}
		
		uniformModelMatrix.location = glGetUniformLocation(id, uniformModelMatrix.name)
		if uniformModelMatrix.location < 0 {
			println("Uniform location \(uniformModelMatrix.name) not found")
		}
		
		vertexAttributePosition.location = glGetAttribLocation(id, vertexAttributePosition.name)
		if vertexAttributePosition.location < 0 {
			println("Attribute location \(vertexAttributePosition.name) not found")
		}
		
		vertexAttributeNormal.location = glGetAttribLocation(id, vertexAttributeNormal.name)
		if vertexAttributeNormal.location < 0 {
			println("Attribute location \(vertexAttributeNormal.name) not found")
		}
		
		vertexAttributeColor.location = glGetAttribLocation(id, vertexAttributeColor.name)
		if vertexAttributeColor.location < 0 {
			println("Attribute location \(vertexAttributeColor.name) not found")
		}
		
		vertexAttributeTexCoord.location = glGetAttribLocation(id, vertexAttributeTexCoord.name)
		if vertexAttributeTexCoord.location < 0 {
			println("Attribute location \(vertexAttributeTexCoord.name) not found")
		}
		
		if !linked {
			print(String.fromCString(infoLog())!)
			return false
		}
		
		return true
	}
	
	
	/**
	Makes the program active
	*/
	final public func use () -> Bool {
		if !linked && !link() {return false}
		glUseProgram(id)
		return true
	}
	
	
	public func getUniform (type: CKOpenGLBaseUniformType) -> CKOpenGLUniform {
		return baseUniforms[type]!
	}
	
	
	public func getVertexAttribute (type: CKOpenGLBaseAttributeType) -> CKOpenGLAttribute {
		return baseAttributes[type]!
	}
	
	
	public func bindVertexAttribute (type: CKOpenGLBaseAttributeType, vecsize: Int = 3, stride: Int = 0) {
		var attribute : CKOpenGLAttribute? = baseAttributes[type]
		if nil == attribute || attribute!.location < 0 {return}
		
		var location : GLuint = GLuint(attribute!.location)
		var pointer : UnsafeMutablePointer<UnsafeMutablePointer<Void>> = UnsafeMutablePointer<UnsafeMutablePointer<Void>>.alloc(1)
		
		glGetVertexAttribPointerv(location, GLenum(GL_VERTEX_ATTRIB_ARRAY_POINTER), pointer)
		glVertexAttribPointer(location, GLint(vecsize), GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(stride), pointer.memory)
		glEnableVertexAttribArray(location)
	}
}


public enum CKOpenGLBaseAttributeType {
	case Position
	case Normal
	case Color
	case TexCoord
}


public enum CKOpenGLBaseUniformType {
	case ModelViewMatrix
	case ProjectionViewMatrix
}