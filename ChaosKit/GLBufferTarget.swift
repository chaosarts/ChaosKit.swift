//
//  GLBufferTarget.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol GLBufferTarget {
	var value : GLenum {get}
	
	func draw (mode: GLenum, count: GLsizei)
}


public struct GLArrayBufferTarget : GLBufferTarget {
	
	public var first : GLint = 0
	
	public var value : GLenum {get {return GLenum(GL_ARRAY_BUFFER)}}
	
	public func draw (mode: GLenum, count: GLsizei) {
		glDrawArrays(mode, first, count)
	}
}


public struct GLElementBufferTarget : GLBufferTarget {
	
	public var type : GLenum = GLenum(GL_UNSIGNED_BYTE)
	
	public var indices : [Int] = []
	
	public var value : GLenum {get {return GLenum(GL_ELEMENT_ARRAY_BUFFER)}}
	
	public func draw (mode: GLenum, count: GLsizei) {
		glDrawElements(mode, count, type, indices)
	}
}