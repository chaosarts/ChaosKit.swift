//
//  GLUniform.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public enum GLUniformAlias : String {
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
	
	case ImageMap = "ImageMap"
	case DiffuseMap = "DiffuseMap"
	case ShadowMap = "ShadowMap"
	case BumpMap = "BumpMap"
	case DisplacementMap = "DisplacementMap"
	case HeightMap = "HeightMap"
	case NormalMap = "NormalMap"
	case SpecularMap = "SpecularMap"
	case GlowMap = "GlowMap"
	case EnviromentMap = "EnviromentMap"
	
	public static let cases : [GLUniformAlias] = [
		.ModelViewMatrix,
		.ProjectionViewMatrix,
		
		.AmbientLightColor,
		.AmbientLightIntensity,
		
		.DiffuseLightColor,
		.DiffuseLightPosition,
		.DiffuseLightIntensity,
		
		.SpecularLightColor,
		.SpecularLightPosition,
		.SpecularLightIntensity,
		.SpecularLightShininess,
		
		.ImageMap,
		.ShadowMap,
		.BumpMap,
		.NormalMap,
		.DisplacementMap,
		.HeightMap,
		.SpecularMap,
		.GlowMap,
		.EnviromentMap
	]
}


/**
Struct that holds information about a uniform location within a program
*/
public struct GLUniformLocation {
	/// The generic name of the uniform of the according program
	public let id : GLuint
	
	/// The name of the uniform variable within the program
	public let name : String
	
	/// The type of the uniform
	public let type : GLenum
	
	public let size : GLint
	
	public init (index: GLuint, name: String, type: GLenum, size: GLint) {
		self.id = index
		self.name = name
		self.type = type
		self.size = size
	}

	
	// SCALAR DOUBLE
	
	public func assign (x: GLdouble) {
		glUniform1d(GLint(id), x)
	}
	
	
	public func assign (count: GLsizei, _ x: UnsafePointer<GLdouble>) {
		glUniform1dv(GLint(id), count, x)
	}
	
	
	public func assign (x: [GLdouble]) {
		assign(GLsizei(x.count), x)
	}
	
	
	// SCALAR FLOAT
	
	public func assign (x: GLfloat) {
		glUniform1f(GLint(id), x)
	}
	
	
	public func assign (count: GLsizei, _ x: UnsafePointer<GLfloat>) {
		glUniform1fv(GLint(id), count, x)
	}
	
	
	public func assign (x: [GLfloat]) {
		assign(GLsizei(x.count), x)
	}
	
	
	// SCALAR INT
	
	public func assign (x: GLint) {
		glUniform1i(GLint(id), x)
	}
	
	
	public func assign (count: GLsizei, _ x: UnsafePointer<GLint>) {
		glUniform1iv(GLint(id), count, x)
	}
	
	
	public func assign (x: [GLint]) {
		assign(GLsizei(x.count), x)
	}
	
	
	// SCALAR UINT
	
	public func assign (x: GLuint) {
		glUniform1ui(GLint(id), x)
	}
	
	
	public func assign (count: GLsizei, _ x: UnsafePointer<GLuint>) {
		glUniform1uiv(GLint(id), count, x)
	}
	
	
	public func assign (x: [GLuint]) {
		assign(GLsizei(x.count), x)
	}
	
	
	// MATRIX 2
	
	public func matrix2dv (count: GLsizei, _ transpose: GLboolean, _ value: [GLdouble]) {
		glUniformMatrix2dv(GLint(id), count, transpose, value)
	}
	
	
	public func matrix2fv (count: GLsizei, _ transpose: GLboolean, _ value: [GLfloat]) {
		glUniformMatrix2fv(GLint(id), count, transpose, value)
	}
	
	
	public func assign (value: mat2, transpose: Bool = false) {
		matrix2fv(GLsizei(1), GLboolean(transpose ? GL_TRUE : GL_FALSE), value.array)
	}
	
	
	public func assign (value: [mat2], transpose: Bool = false) {
		var array : [GLfloat] = []
		for i in 0..<(value.count) {array += value[i].array}
		matrix2fv(GLsizei(value.count), GLboolean(transpose ? GL_TRUE : GL_FALSE), array)
	}
	
	
	// MATRIX 3
	
	public func matrix3dv (count: GLsizei, _ transpose: GLboolean, _ value: [GLdouble]) {
		glUniformMatrix3dv(GLint(id), count, transpose, value)
	}
	
	
	public func matrix3fv (count: GLsizei, _ transpose: GLboolean, _ value: [GLfloat]) {
		glUniformMatrix3fv(GLint(id), count, transpose, value)
	}
	
	
	public func assign (value: mat3, transpose: Bool = false) {
		matrix3fv(GLsizei(1), GLboolean(transpose ? GL_TRUE : GL_FALSE), value.array)
	}
	
	
	public func assign (value: [mat3], transpose: Bool = false) {
		var array : [GLfloat] = []
		for i in 0..<(value.count) {array += value[i].array}
		matrix3fv(GLsizei(value.count), GLboolean(transpose ? GL_TRUE : GL_FALSE), array)
	}
	
	
	// MATRIX 4
	
	public func matrix4dv (count: GLsizei, _ transpose: GLboolean, _ value: [GLdouble]) {
		glUniformMatrix4dv(GLint(id), count, transpose, value)
	}
	
	
	public func matrix4fv (count: GLsizei, _ transpose: GLboolean, _ value: [GLfloat]) {
		glUniformMatrix4fv(GLint(id), count, transpose, value)
	}
	
	
	public func assign (value: mat4, transpose: Bool = false) {
		matrix4fv(GLsizei(1), GLboolean(transpose ? GL_TRUE : GL_FALSE), value.array)
	}
	
	
	public func assign (value: [mat4], transpose: Bool = false) {
		var array : [GLfloat] = []
		for i in 0..<(value.count) {array += value[i].array}
		matrix4fv(GLsizei(value.count), GLboolean(transpose ? GL_TRUE : GL_FALSE), array)
	}
}
