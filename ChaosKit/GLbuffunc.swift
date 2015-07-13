//
//  GLbuffunc.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 29.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLbuffunc {
	
}


public struct GLdepthfunc {
	
	public var flag : GLenum = GLenum(GL_ALWAYS)
	
	public init (_ flag: GLenum) {
		self.flag = flag
	}
	
	public func apply () {
		glDepthFunc(flag)
	}
}