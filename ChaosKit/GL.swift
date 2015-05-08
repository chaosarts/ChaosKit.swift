//
//  GL.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 04.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public let GL_TEXTURES : [Int32] = [
	GL_TEXTURE0,
	GL_TEXTURE1,
	GL_TEXTURE2,
	GL_TEXTURE3,
	GL_TEXTURE4,
	GL_TEXTURE5,
	GL_TEXTURE6,
	GL_TEXTURE7,
	GL_TEXTURE8,
	GL_TEXTURE9,
	GL_TEXTURE10,
	GL_TEXTURE11,
	GL_TEXTURE12,
	GL_TEXTURE13,
	GL_TEXTURE14,
	GL_TEXTURE15,
	GL_TEXTURE16,
	GL_TEXTURE17,
	GL_TEXTURE18,
	GL_TEXTURE19,
	GL_TEXTURE20,
	GL_TEXTURE21,
	GL_TEXTURE22,
	GL_TEXTURE23,
	GL_TEXTURE24,
	GL_TEXTURE25,
	GL_TEXTURE26,
	GL_TEXTURE27,
	GL_TEXTURE28,
	GL_TEXTURE29,
	GL_TEXTURE20,
	GL_TEXTURE21,
	GL_TEXTURE22,
	GL_TEXTURE23,
	GL_TEXTURE24,
	GL_TEXTURE25,
	GL_TEXTURE26,
	GL_TEXTURE27,
	GL_TEXTURE28,
	GL_TEXTURE29,
	GL_TEXTURE30,
	GL_TEXTURE31
]

public typealias DisplayObjectID = UInt32





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