//
//  CKOpenGLUniform.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public struct CKOpenGLUniform {
	
	public let name : String
	
	public var type : GLenum?
	
	public var size : GLint?
	
	public var location : GLint = -1
	
	public init (name: String, type: GLenum) {
		self.name = name
		self.type = type
	}
	
	public init (name: String) {
		self.name = name
	}
}
