//
//  CKOpenGLBase.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/**
This is the base class for all OpenGL wrapper classes, which requires an id for
gl...-Functions, like Programs, Shaders etc
*/
public class CKOpenGLBase: NSObject {
	
	/** This is the id, which can be used, if required */
	public final let id : GLuint
	
	/** Initializes the object. Is only used by subclasses within the framework. */
	internal init (id: GLuint) {
		self.id = id
	}
}
