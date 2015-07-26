//
//  GLBufferTarget.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

public protocol GLBufferTarget {
	func draw (mode: GLenum, _ count: GLsizei)
	func draw (shape: GLShape)
}


public struct GLArrayBufferTarget : GLBufferTarget {
	
	public var first : GLint = 0
	
	public func draw (mode: GLenum, _ count: GLsizei) {
		glDrawArrays(mode, first, count)
	}
	
	public func draw (shape: GLShape) {
		glDrawArrays(shape.mode, first, GLsizei(shape.geometry.indexlist.count))
	}
}


public struct GLElementBufferTarget : GLBufferTarget {
	
	public var type : GLenum = GLenum(GL_UNSIGNED_BYTE)
	
	public var indexlist : [Int] = []
	
	public func draw (mode: GLenum, _ count: GLsizei) {
		glDrawElements(mode, count, type, indexlist)
	}
	
	public func draw (shape: GLShape) {
		var geometry : GLgeom = shape.geometry
		glDrawElements(shape.mode, GLsizei(geometry.indexlist.count), GLenum(GL_UNSIGNED_BYTE), geometry.indexlist)
	}
}