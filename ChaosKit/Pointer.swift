//
//  Pointer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


/**
Returns a pointer to the beginning of an array

:param: value The value to wrap in to a pointer struct
:return: A pointer
*/
public func toUnsafePointer<T> (value: [T]) -> UnsafePointer<T> {
	var mptr : UnsafeMutablePointer<T> = UnsafeMutablePointer<T>.alloc(value.count)
	mptr.initializeFrom(value)
	var ptr = UnsafePointer<T>(mptr)
	return ptr
}


/**
Returns a pointer with passed value in memory

:param: value The value to wrap in to a pointer struct
:return: A pointer
*/
public func toUnsafePointer<T>(value: T) -> UnsafePointer<T> {
	var ptr : UnsafeMutablePointer<T> = UnsafeMutablePointer<T>.alloc(1)
	ptr.initialize(value)
	return UnsafePointer<T>(ptr)
}


/** 
Converts the passed value to an unsafe void pointer

:param: value The value to wrap in to a pointer struct
:return: A void pointer
*/
public func toUnsafeVoidPointer<T> (value: T) -> UnsafePointer<Void> {
	return UnsafePointer<Void>(toUnsafePointer(T))
}


/**
Converts the passed array to an unsafe void pointer

:param: value The value to wrap in to a pointer struct
:return: A void pointer
*/
public func toUnsafeVoidPointer<T> (value: [T]) -> UnsafePointer<Void> {
	return UnsafePointer<Void>(toUnsafePointer([T]))
}