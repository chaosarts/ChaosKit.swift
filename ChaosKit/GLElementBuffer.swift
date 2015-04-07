//
//  GLElementBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 01.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GLElementBuffer : GLBuffer {
	
	/// Provides the indices data type
	public var type : GLenum
	
	public var indices : [Int] = []
	
	public init (type t: Int32 = GL_UNSIGNED_BYTE) {
		type = GLenum(t)
		super.init(target: GL_ARRAY_BUFFER)
	}
	
	
	public func draw (mode: GLenum) {
		glDrawElements(mode, count, type, toUnsafeVoidPointer(indices))
	}
}