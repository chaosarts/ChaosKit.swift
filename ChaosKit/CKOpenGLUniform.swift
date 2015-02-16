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
	
	public var locations : [GLint] = []
	
	subscript (index: Int) -> GLint {
		get {
			assert(valid(index), "Bad index access for uniform")
			return locations[index]
		}
		
		set {
			assert(valid(index), "Bad index access for uniform")
			locations[index] = newValue
		}
	}
	
	public init (name: String, type: GLenum) {
		self.name = name
		self.type = type
	}
	
	public init (name: String) {
		self.name = name
	}
	
	
	private func valid (index: Int) -> Bool {
		return nil != size && index > 0 && index < Int(size!)
	}
}
