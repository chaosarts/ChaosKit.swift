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
public class GLShader {
	
	/// Provides the id of the shader
	public let id : GLuint
	
	/// Provides a list of shader source objects
	public private(set) var sources : [GLsrcfile] = []
	
	/// Provides the type of the shader
	public var type : GLenum {get {return GLenum(iv(GLenum(GL_SHADER_TYPE)))}}
	
	/// Indicates the delete status of the shader
	public var deleteStatus : Bool {get {return GLboolean(iv(GLenum(GL_DELETE_STATUS))) == GLboolean(GL_TRUE)}}
	
	/// Indicates the compile status of the shader
	public var compileStatus : Bool {get {return GLboolean(iv(GLenum(GL_COMPILE_STATUS))) == GLboolean(GL_TRUE)}}
	
	/// Indicates the info log length
	public var infoLogLength : Int {get {return Int(iv(GLenum(GL_COMPILE_STATUS)))}}
	
	/// Provides the info log about the shader
	public var infolog : String {
		get {
			var bufSize : GLint = iv(GL_INFO_LOG_LENGTH)
			var log : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(Int(bufSize))
			glGetShaderInfoLog(id, bufSize, nil, log)
			
			let string : String? = String.fromCString(log)
			log.dealloc(Int(bufSize))
			log.destroy()
			
			return string == nil ? "" : string!
		}
	}
	
	
	/**
	Initiliazes a shader of given type
	
	:param: type The type of the shader
	:param: sources A list of shader source objects
	*/
	public init (type: GLenum, sources: [GLsrcfile]) {
		self.id = glCreateShader(type)
		self.sources = sources
	}
	
	
	/**
	Initiliazes a shader of given type and with given source
	
	:param: type The type of the shader
	:param: source A list of shader source objects
	*/
	public convenience init (type: GLenum, source: GLsrcfile) {
		self.init(type: type, sources: [source])
	}
	
	
	/**
	Initializes the shader with no sources
	
	:param: type The type of the shader
	*/
	public convenience init (type: GLenum) {
		let sources : [GLsrcfile] = []
		self.init(type: type, sources: sources)
	}
	
	/**
	Initializes the shader with the one source string
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: source The source code as string
	*/
	public convenience init (type : GLenum, source : String) {
		let sources : [GLsrcfile] = [GLsrcfile(content: source)]
		self.init(type: type, sources: sources)
	}
	
	
	/**
	Initializes the shader with the one or more source strings
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: sources The source codes as string
	*/
	public convenience init (type : GLenum, sources : [String]) {
		let sources : [GLsrcfile] = sources.map({element in return GLsrcfile(content: element)})
		self.init(type: type, sources: sources)
	}
	
	
	/**
	Initializes the shader with one or more files
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: files The files, that contains the sources
	*/
	public convenience init (type: GLenum, files: [String], encoding: NSStringEncoding = NSUTF8StringEncoding) {
		var sources : [String] = []
		var fileManager : NSFileManager = NSFileManager.defaultManager()
		
		for file in files {
			if !fileManager.fileExistsAtPath(file) {
				warn("GLShader file \(file) not found.")
				continue
			}
			
			var fileContent : String = NSString(contentsOfFile: file, encoding: encoding, error: nil)! as String
			sources.append(fileContent)
		}
		
		self.init(type: type, sources: sources)
	}
	
	
	/**
	Initializes the shader with a file
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: file The file, that contains the source
	*/
	public convenience init (type: GLenum, file: String, encoding: NSStringEncoding = NSUTF8StringEncoding) {
		self.init(type: type, files: [file], encoding: encoding)
	}
	
	
	/**
	Initializes the shader with one or more resource files
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: resources The resource files, that contains the sources
	*/
	public convenience init (type: GLenum, resources: [String], encoding: NSStringEncoding = NSUTF8StringEncoding) {
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
	Initializes the shader with a resource file
	
	:param: type The shader type like GL_VERTEX_SHADER
	:param: resource The resource file, that contains the source
	*/
	public convenience init (type: GLenum, resource: String, encoding: NSStringEncoding = NSUTF8StringEncoding) {
		self.init(type: type, resources: [resource], encoding: encoding)
	}
	
	
	/**
	A shortcut for glShaderiv. Returns information about the shader
	
	:param: pname A paramater value for glShaderiv like GL_COMPILE_STATUS
	:returns: The unsafe mutable pointer that has been passed to glShaderiv within this method. Contains the result of the request
	*/
	public func iv (pname : GLenum) -> GLint {
		var param : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		glGetShaderiv(id, GLenum(pname), param)
		
		let val : GLint = param.memory
		param.dealloc(1)
		param.destroy()
		return val
	}
	
	
	/**
	A shortcut for glShaderiv. Returns information about the shader
	
	:param: pname A paramater value for glShaderiv like GL_COMPILE_STATUS
	:returns: The unsafe mutable pointer that has been passed to glShaderiv within this method. Contains the result of the request
	*/
	public func iv (pname : Int32) -> GLint {
		return iv(GLenum(pname))
	}
	
	
	/**
	Appends a source to the shader
	
	:param: source The shader source object
	*/
	public func append (source: GLsrcfile) {
		sources.append(source)
	}
	
	
	/**
	Appends a source to the shader
	
	:param: source The shader source object
	*/
	public func extend (sources: [GLsrcfile]) {
		self.sources.extend(sources)
	}
	
	
	/**
	Compiles the shader
	*/
	public func compile () {
		var cstrings : UnsafeMutablePointer<UnsafePointer<GLchar>> = UnsafeMutablePointer<UnsafePointer<GLchar>>.alloc(sources.count)
		var lengths : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(sources.count)
		for index in 0..<sources.count {
			let cstring : Cstring? = sources[index].cstring
			if nil == cstring {continue}
			cstrings[index] = cstring!.ptr
			lengths[index] = cstring!.isNullTerminated ? -1 : GLint(cstring!.count)
		}
		
		glShaderSource(id, GLsizei(sources.count), cstrings, lengths)
		glPrintError_CK()
		
		glCompileShader(id)
		glPrintError_CK()
		
		cstrings.destroy()
		cstrings.dealloc(sources.count)
		lengths.destroy()
		lengths.dealloc(sources.count)
		
		if (iv(GL_COMPILE_STATUS) != GL_TRUE) {
			println(infolog)
		}

	}
}