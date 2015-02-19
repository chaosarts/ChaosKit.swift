//
//  CKOpenGLAttribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa


/**
Enumeration of vertex attribute types
*/
public enum CKOpenGLAttributeType : Int {
	case Position
	case Color
	case Normal
	case TexCoord
}


public struct CKOpenGLAttributeInfo {
	
	public let name : String
	
	public let target : CKOpenGLAttributeType
	
	public var type : GLenum?
	
	public var size : GLint?
	
	public var location : GLint = -1
	
	public var locations : [GLuint] = []
	
	
	public init(name: String, target: CKOpenGLAttributeType) {
		self.name = name
		self.target = target
	}
}
