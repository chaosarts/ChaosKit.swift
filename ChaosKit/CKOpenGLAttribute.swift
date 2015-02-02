//
//  CKOpenGLAttribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public struct CKOpenGLAttribute {
	
	public let name : String
	
	public let index : GLuint
	
	public init(index: GLuint, name: String, type: GLenum, size: GLint, length: GLsizei) {
		self.name = name
		self.index = index
	}
}
