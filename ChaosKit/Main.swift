//
//  .swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 29.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

/*
|--------------------------------------------------------------------------
| Typealias
|--------------------------------------------------------------------------
*/

public typealias BlockMap = [AttributeTarget : BufferBlock]
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

