//
//  CKOpenGLBase.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLBase: NSObject {
	public let id : GLuint
	
	internal init (id: GLuint) {
		self.id = id
	}
}
