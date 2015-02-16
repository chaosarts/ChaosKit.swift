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
	
	public let target : CKOpenGLTargetAttribute
	
	public var type : GLenum?
	
	public var size : GLint?
	
	public var location : GLint = -1
	
	
	public init(name: String, target: CKOpenGLTargetAttribute) {
		self.name = name
		self.target = target
	}
}


public enum CKOpenGLTargetAttribute {
	case Position
	case Color
	case TexCoord
	case Normal
}
