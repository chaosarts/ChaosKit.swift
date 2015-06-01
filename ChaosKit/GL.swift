//
//  GL.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 04.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GL {
	
	/// Provides the int params for glGetIntegerv
	private static var _intParams : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
	
	/// Provides the int params for glGetFloatv
	private static var _floatParams : UnsafeMutablePointer<GLfloat> = UnsafeMutablePointer<GLfloat>.alloc(1)
	
	/// Provides the int params for glGetBooleanv
	private static var _boolParams : UnsafeMutablePointer<GLboolean> = UnsafeMutablePointer<GLboolean>.alloc(1)
	
	/// Provides the value of the active multitexture unit
	public static var ACTIVE_TEXTURE : GLint {get {return GL.getIntegerv(GL_ACTIVE_TEXTURE).memory}}
	
	/// Provides the name of the current active program
	public static var CURRENT_PROGRAM : GLint {get {return GL.getIntegerv(GL_CURRENT_PROGRAM).memory}}
	
	/// Provides the maximum supported texture image
	public static let MAX_COMBINED_TEXTURE_IMAGE_UNITS : GLint = {return GL.getIntegerv(GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS).memory}()
	
	/// Provides the maximum supported texture image size
	public static let MAX_TEXTURE_SIZE : GLint = {return GL.getIntegerv(GL_MAX_TEXTURE_SIZE).memory}()
	
	
	/**
	Just like glGetIntegerv
	
	:param: pname Specifies the parameter value to be returned. The symbolic constants in the list below are accepted.
	:return: The value or values of the specified parameter.
	*/
	public class func getIntegerv (pname: Int32) -> UnsafeMutablePointer<GLint> {
		glGetIntegerv(GLenum(pname), _intParams)
		return _intParams
	}
	
	
	/**
	Just like glGetFloatv
	
	:param: pname Specifies the parameter value to be returned. The symbolic constants in the list below are accepted.
	:return: The value or values of the specified parameter.
	*/
	public class func getFloatv (pname: Int32) -> UnsafeMutablePointer<GLfloat> {
		glGetFloatv(GLenum(pname), _floatParams)
		return _floatParams
	}
	
	
	/**
	Just like glGetBooleanv
	
	:param: pname Specifies the parameter value to be returned. The symbolic constants in the list below are accepted.
	:return: The value or values of the specified parameter.
	*/
	public class func getBooleanv (pname: Int32) -> UnsafeMutablePointer<GLboolean> {
		glGetBooleanv(GLenum(pname), _boolParams)
		return _boolParams
	}
}

public let GL_TEXTURES : [Int32] = [
	GL_TEXTURE0,
	GL_TEXTURE1,
	GL_TEXTURE2,
	GL_TEXTURE3,
	GL_TEXTURE4,
	GL_TEXTURE5,
	GL_TEXTURE6,
	GL_TEXTURE7,
	GL_TEXTURE8,
	GL_TEXTURE9,
	GL_TEXTURE10,
	GL_TEXTURE11,
	GL_TEXTURE12,
	GL_TEXTURE13,
	GL_TEXTURE14,
	GL_TEXTURE15,
	GL_TEXTURE16,
	GL_TEXTURE17,
	GL_TEXTURE18,
	GL_TEXTURE19,
	GL_TEXTURE20,
	GL_TEXTURE21,
	GL_TEXTURE22,
	GL_TEXTURE23,
	GL_TEXTURE24,
	GL_TEXTURE25,
	GL_TEXTURE26,
	GL_TEXTURE27,
	GL_TEXTURE28,
	GL_TEXTURE29,
	GL_TEXTURE20,
	GL_TEXTURE21,
	GL_TEXTURE22,
	GL_TEXTURE23,
	GL_TEXTURE24,
	GL_TEXTURE25,
	GL_TEXTURE26,
	GL_TEXTURE27,
	GL_TEXTURE28,
	GL_TEXTURE29,
	GL_TEXTURE30,
	GL_TEXTURE31
]

public typealias DisplayObjectID = UInt32





/*
|--------------------------------------------------------------------------
| Functions
|--------------------------------------------------------------------------
*/

/**
Determines if an error has occured or not

:return: True, when an opengl error has occured
*/
public func glHasError_CK () -> Bool {
	return glGetError() != GLenum(GL_NO_ERROR)
}

/**
Prints the OpenGL error as human readable text
*/
public func glPrintError_CK () {
	#if DEBUG
	var error : GLenum = glGetError()
	
	if error != GLenum(GL_NO_ERROR) {
		
		var message : String = ""
		
		switch error {
		case GLenum(GL_INVALID_ENUM):
			message = "Invalid enum"
		case GLenum(GL_INVALID_FRAMEBUFFER_OPERATION):
			message = "Invalid framebuffer operation"
		case GLenum(GL_INVALID_INDEX):
			message = "Invalid index"
		case GLenum(GL_INVALID_OPERATION):
			message = "Invalid operation"
		case GLenum(GL_INVALID_VALUE):
			message = "Invalid value"
		default:
			message = "Something is invalid "
		}
		
		warn(message)
	}
	#endif
}
