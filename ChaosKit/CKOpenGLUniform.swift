//
//  CKOpenGLUniform.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

class CKOpenGLUniform: CKOpenGLBase {
	
	let length : UnsafeMutablePointer<GLsizei>
	let size : UnsafeMutablePointer<GLint>
	let type : UnsafeMutablePointer<GLenum>
	let name : String
	
	let program : CKOpenGLProgram
	
	init(id: GLuint, program: CKOpenGLProgram) {
		
		var length : UnsafeMutablePointer<GLsizei> = UnsafeMutablePointer<GLsizei>()
		var size : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>()
		var type : UnsafeMutablePointer<GLenum> = UnsafeMutablePointer<GLenum>()
		var name : UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>()
		
		glGetActiveUniform(program.id, id, program.iv(GL_ACTIVE_UNIFORM_MAX_LENGTH), length, size, type, name)
		
		self.length = length
		self.size = size
		self.type = type
		self.name = String.fromCString(name)!
		
		self.program = program
		
		super.init(id: id)
	}}
