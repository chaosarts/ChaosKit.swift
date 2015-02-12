//
//  CKOpenGLUniform.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public struct CKOpenGLUniform {
	
	public var name : String
	
	public var type : GLenum
	
	public var location : GLint = -1
	
	init (name: String, type: GLenum) {
		self.name = name
		self.type = type
	}
	
	init (name: String, type: Int32) {
		self.name = name
		self.type = GLenum(type)
	}
	
//	let length : UnsafeMutablePointer<GLsizei>
//	let size : UnsafeMutablePointer<GLint>
//	let type : UnsafeMutablePointer<GLenum>
//	let name : String
//	
//	let program : CKOpenGLProgram
//	
//	init(id: GLuint, program: CKOpenGLProgram) {
//		
//		var length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>()
//		var size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>()
//		var type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>()
//		var name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>()
//		
//		glGetActiveUniform(program.id, id, program.iv(GL_ACTIVE_UNIFORM_MAX_LENGTH).memory, length, size, type, name)
//		
//		self.length = length
//		self.size = size
//		self.type = type
//		self.name = String.fromCString(name)!
//		
//		self.program = program
//		
//		super.init(id: id)
//	}
}
