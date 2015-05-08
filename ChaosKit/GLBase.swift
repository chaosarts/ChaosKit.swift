//
//  GLBase.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol GLIdentifiable {
	var id : GLuint {get}
}

public protocol GLBindable {
	func bind ()
	func unbind ()
}


/**
This is the GLBase class for all OpenGL wrapper classes, which requires an id for
gl...-Functions, like GLPrograms, GLShaders etc
*/
public class GLBase: NSObject, GLIdentifiable {
	
	internal var _ivCache : [Int32 : GLint] = [Int32 : GLint]()
	
	/// This is the id, which can be used, if required
	public final let id : GLuint
	
	/// Initializes the object. Is only used by subclasses within the framework.
	internal init (id: GLuint) {
		self.id = id
	}
	
	
	/** 
	Return the value or values of a selected parameter 
	
	:param: pname The name of the paramater to get
	*/
	public class func getBooleanv (pname: Int32) -> GLboolean {
		var params : UnsafeMutablePointer<GLboolean> = UnsafeMutablePointer<GLboolean>.alloc(1)
		glGetBooleanv(GLenum(pname), params)
		return params.memory
	}
	
	
	/**
	Return the value or values of a selected parameter
	
	:param: pname The name of the paramater to get
	*/
	public class func getBool (pname: Int32) -> Bool {
		return getBooleanv(pname) == GLboolean(GL_TRUE)
	}
	
	
	/**
	Return the value or values of a selected parameter
	
	:param: pname The name of the paramater to get
	*/
	public class func getDoublev (pname: Int32) -> GLdouble {
		var params : UnsafeMutablePointer<GLdouble> = UnsafeMutablePointer<GLdouble>.alloc(1)
		glGetDoublev(GLenum(pname), params)
		return params.memory
	}
	
	
	/**
	Return the value or values of a selected parameter
	
	:param: pname The name of the paramater to get
	*/
	public class func getFloatv (pname: Int32) -> GLfloat {
		var params : UnsafeMutablePointer<GLfloat> = UnsafeMutablePointer<GLfloat>.alloc(1)
		glGetFloatv(GLenum(pname), params)
		return params.memory
	}
	
	
	/**
	Return the value or values of a selected parameter
	
	:param: pname The name of the paramater to get
	*/
	public class func getIntegerv (pname: Int32) -> GLint {
		var params : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		glGetIntegerv(GLenum(pname), params)
		return params.memory
	}
	
	
	/**
	Return the value or values of a selected parameter
	
	:param: pname The name of the paramater to get
	*/
	public class func getInteger64v (pname: Int32) -> GLint64 {
		var params : UnsafeMutablePointer<GLint64> = UnsafeMutablePointer<GLint64>.alloc(1)
		glGetInteger64v(GLenum(pname), params)
		return params.memory
	}
	
	
	/**
	Return the value or values of a selected parameter
	
	:param: pname The name of the paramater to get
	*/
	public func validateAction (funcname: String) {
		var error : GLenum = glGetError()
		
		if error != GLenum(GL_NO_ERROR) {
			
			var classname : String = _stdlib_getDemangledTypeName(self)
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
			
			message = message + " in class <" + self.className + "@" + funcname + ">"
			warn(message)
		}
	}
}


/*
|--------------------------------------------------------------------------
| Typealias
|--------------------------------------------------------------------------
*/

public typealias RGBAColor = (r: GLclampf, g: GLclampf, b: GLclampf, a: GLclampf)
public typealias RGBColor = (r: GLclampf, g: GLclampf, b: GLclampf)


public protocol Placeable {
	var position : vec3 {get}
}


public protocol Colorable {
	var color : vec4 {get}
}


public protocol Rotateable {
	var rotation : vec3 {get}
}


public protocol Orientable {
	var orientation : vec3 {get}
}


