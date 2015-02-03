//
//  core.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 21.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

prefix operator * {}

public prefix func *<T>(ptr : UnsafePointer<T>) -> T{
	return ptr.memory
}

public prefix func *<T>(ptr : UnsafeMutablePointer<T>) -> T{
	return ptr.memory
}

public func *<T: UnsignedIntegerType>(l: String, r: T) -> String {
	var output = l
	var count : T = 0
	
	while count < r {
		output = output + l
		count++
	}
	
	return output
}


public func *<T: UnsignedIntegerType>(l: T, r: String) -> String {
	return r * l
}


public func *(l: String, r: Int) -> String {
	return l * UInt32(r)
}


public func *(l: Int, r: String) -> String {
	return UInt32(l) * r
}