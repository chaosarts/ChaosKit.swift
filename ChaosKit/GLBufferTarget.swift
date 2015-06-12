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
	
	func draw (mode m: GLenum, count c: GLsizei)
}


public struct GLArrayBufferTarget : GLBufferTarget {
	
	public var first : GLint = 0
	
	public var value : GLenum {get {return GLenum(GL_ARRAY_BUFFER)}}
	
	public func draw (mode m: GLenum, count c: GLsizei) {
		glDrawArrays(m, first, c)
	}
}


public struct GLElementBufferTarget : GLBufferTarget {
	
	public var type : GLenum
	
	public var indices : [Int]
	
	public var value : GLenum {get {return GLenum(GL_ELEMENT_ARRAY_BUFFER)}}
	
	
	public init (indices: [Int], type: Int32 = GL_UNSIGNED_BYTE) {
		self.indices = indices
		self.type = GLenum(type)
	}
	
	public func draw (mode m: GLenum, count c: GLsizei) {
		glDrawElements(m, c, type, indices)
	}
}