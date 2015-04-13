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


/**
This is the GLBase class for all OpenGL wrapper classes, which requires an id for
gl...-Functions, like GLPrograms, GLShaders etc
*/
public class GLBase: NSObject, GLIdentifiable {
	
	internal var _ivCache : [Int32 : GLint] = [Int32 : GLint]()
	
	/// This is the id, which can be used, if required
	public final let id : GLuint
	
	/// Initializes the object. Is only used by subclasses within the framework.
	internal init (id: GLuint) {
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


/*
|--------------------------------------------------------------------------
| Functions
|--------------------------------------------------------------------------
*/

public func toUnsafePointer<T> (value: [T]) -> UnsafePointer<T> {
	var mptr : UnsafeMutablePointer<T> = UnsafeMutablePointer<T>.alloc(value.count)
	mptr.initializeFrom(value)
	var ptr = UnsafePointer<T>(mptr)
	return ptr
}

public func toUnsafePointer<T>(value: T) -> UnsafePointer<T> {
	var ptr : UnsafeMutablePointer<T> = UnsafeMutablePointer<T>.alloc(1)
	ptr.initialize(value)
	return UnsafePointer<T>(ptr)
}


public func toUnsafeVoidPointer<T> (value: T) -> UnsafePointer<Void> {
	return UnsafePointer<Void>(toUnsafePointer(T))
}

public func toUnsafeVoidPointer<T> (value: [T]) -> UnsafePointer<Void> {
	return UnsafePointer<Void>(toUnsafePointer([T]))
}


