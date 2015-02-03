//
//  CKOpenGLShader.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL
import GLKit

public class CKOpenGLShader: CKOpenGLBase {
	
	public convenience init? (type : GLenum, source : String) {
		self.init(type: type, sources: [source])
	}
	
	
	public init? (type : GLenum, sources : [String]) {
		super.init(id: glCreateShader(type))
		setSources(sources)
	}
	
	
	public convenience init? (type: GLenum, file: String, encoding: NSStringEncoding) {
		self.init(type: type, files: [file], encoding: encoding)
	}
	
	
	public init? (type: GLenum, files: [String], encoding: NSStringEncoding) {
		super.init(id: glCreateShader(type))
		
		var sources : [String] = []
		var fileManager : NSFileManager = NSFileManager.defaultManager()
		
		for file in files {
			if !fileManager.fileExistsAtPath(file) {
				continue
			}
			
			var fileContent : String = NSString(contentsOfFile: file, encoding: encoding, error: nil)!
			sources.append(fileContent)
		}
		setSources(sources)
	}
	
	
	public func iv (pname : Int32) -> GLint {
		var param : GLint = GLint()
		glGetShaderiv(id, GLenum(pname), &param)
		return param
	}
	
	
	public func infolog () -> [GLchar] {
		var bufSize : GLint = iv(GL_INFO_LOG_LENGTH)
		var log : [GLchar] = [GLchar]()
		glGetShaderInfoLog(id, bufSize, nil, &log)
		return log
	}
	
	
	private func setSources (sources: [String]) {
		var sourceCount : Int = sources.count
		var length : [GLint] = []
		var sourcePtrs : [UnsafePointer<GLchar>] = []
		
		for source in sources {
			var cString : [GLchar] = source.cStringUsingEncoding(NSUTF8StringEncoding)!
			var cStringPtr : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.alloc(cString.count)
			cStringPtr.initializeFrom(cString)
			sourcePtrs.append(cStringPtr)
			length.append(GLint(source.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
		}
		
		glShaderSource(id, GLsizei(sourceCount), &sourcePtrs, &length)
		glCompileShader(id)
		
		if (iv(GL_COMPILE_STATUS) != GL_TRUE) {
			print(String.fromCString(infolog())!)
		}
	}
}
