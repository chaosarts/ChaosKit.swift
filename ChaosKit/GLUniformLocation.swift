//
//  GLUniform.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa




/**
Struct that holds information about a uniform location within a program
*/
public class GLUniformLocation : GLLocation {
	public init (index: GLuint, name: String) {
		super.init(index, name)
	}
}