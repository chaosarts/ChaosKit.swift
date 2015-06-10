//
//  GLBase.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol GLIdentifiable {
	var id : GLuint {get}
}

public protocol GLBindable {
	func bind ()
	func unbind ()
}

public protocol Placeable {
	var position : vec3 {get}
}


public protocol Colorable {
	var color : vec4 {get}
}


public protocol Rotateable {
	var rotation : vec3 {get}
}


public protocol Orientable {
	var orientation : vec3 {get}
}


/**
This is the GLBase class for all OpenGL wrapper classes, which requires an id for
gl...-Functions, like GLPrograms, GLShaders etc
*/
public class GLBase: GLIdentifiable {
	
	/// This is the id, which can be used, if required
	public let id : GLuint
	
	/// Initializes the GL object
	internal init (_ id: GLuint) {
		self.id = id
	}
}


/*
|--------------------------------------------------------------------------
| Typealias
|--------------------------------------------------------------------------
*/

public typealias RGBAColor = (r: GLclampf, g: GLclampf, b: GLclampf, a: GLclampf)
public typealias RGBColor = (r: GLclampf, g: GLclampf, b: GLclampf)


