//
//  GLShader.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL
import OpenGL.GL

/**
Wrapper class for shaders
*/
public class GLShader: GLBase {
	
	/**
	Initializes the shader with the one source string
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: source The source code as string
	*/
	public convenience init? (type : GLenum, source : String) {
		self.init(type: type, sources: [source])
	}
	
	
	/**
	Initializes the shader with the one or more source strings
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: sources The source codes as string
	*/
	public init? (type : GLenum, sources : [String]) {
		super.init(glCreateShader(type))
		setSources(sources)
	}
	
	
	/**
	Initializes the shader with a resource file
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: resource The resource file, that contains the source
	*/
	public convenience init? (type: GLenum, resource: String,
		encoding: NSStringEncoding = NSUTF8StringEncoding) {
			self.init(type: type, resources: [resource], encoding: encoding)
	}
	
	
	/**
	Initializes the shader with one or more resource files
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: resources The resource files, that contains the sources
	*/
	public convenience init? (type: GLenum, resources: [String],
		encoding: NSStringEncoding = NSUTF8StringEncoding) {
		
		var files : [String] = []
		var bundle : NSBundle = NSBundle.mainBundle()
		
		for resource in resources {
			var file : String? = bundle.pathForResource(resource, ofType: nil)
			if nil == file {
				error("GLShader resource \(file) not found.")
				continue
			}
			files.append(file!)
		}
		self.init(type: type, files: files, encoding: encoding)
	}
	
	
	/**
	Initializes the shader with a file
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: file The file, that contains the source
	*/
	public convenience init? (type: GLenum, file: String,
		encoding: NSStringEncoding = NSUTF8StringEncoding) {
		self.init(type: type, files: [file], encoding: encoding)
	}
	
	
	/**
	Initializes the shader with one or more files
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: files The files, that contains the sources
	*/
	public convenience init? (type: GLenum, files: [String],
		encoding: NSStringEncoding = NSUTF8StringEncoding) {
		
		var sources : [String] = []
		var fileManager : NSFileManager = NSFileManager.defaultManager()
		
		for file in files {
			if !fileManager.fileExistsAtPath(file) {
				error("GLShader file \(file) not found.")
				continue
			}
			
			var fileContent : String = NSString(contentsOfFile: file, encoding: encoding, error: nil)! as String
			sources.append(fileContent)
		}
		
		self.init(type: type, sources: sources)
	}
	
	
	/**
	A shortcut for glShaderiv. Returns information about the shader
	
	:param: pname A paramater value for glShaderiv like GL_COMPILE_STATUS
	:returns: The unsafe mutable pointer that has been passed to glShaderiv within this method. Contains the result of the request
	*/
	public func iv (pname : Int32) -> GLint {
		var param : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		glGetShaderiv(id, GLenum(pname), param)
		return param.memory
	}
	
	
	/**
	Returns the info log about the shader as UnsafeMutablePointer<GLchar>/C-String
 	*/
	public func infolog () -> UnsafeMutablePointer<GLchar> {
		var bufSize : GLint = iv(GL_INFO_LOG_LENGTH)
		var log : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(1)
		glGetShaderInfoLog(id, bufSize, nil, log)
		return log
	}
	
	
	/** 
	Sets the source for this shader. The shader will be compiled immediatley
	*/
	private func setSources (sources: [String]) {
		var cstrings : UnsafeMutablePointer<UnsafePointer<GLchar>> = UnsafeMutablePointer<UnsafePointer<GLchar>>.alloc(1)
		var length : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		
		var cstring : [GLchar] = ("\n".join(sources)).cStringUsingEncoding(NSUTF8StringEncoding)!
		cstrings.initialize(toUnsafePointer(cstring))
		length.initialize(GLint(cstring.count))
		
		glShaderSource(id, GLsizei(1), cstrings, length)
		glPrintError_CK()
		
		glCompileShader(id)
		
		if (iv(GL_COMPILE_STATUS) != GL_TRUE) {
			print(String.fromCString(infolog())!)
		}
		
		
	}
}