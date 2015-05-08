//
//  GLClearMask.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 08.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLClearMask {
	var bitmask : Int32 {get}
	
	func clear ()
}


public struct GLColorClearMask : GLClearMask {
	public let bitmask : Int32 = GL_COLOR_BUFFER_BIT
	
	public var value : RGBAColor = (0, 0, 0, 0)
	
	public init () {}
	
	public init (_ color: RGBAColor) {
		value = color
	}
	
	public func clear () {
		glClearColor(value.r, value.g, value.b, value.a)
	}
}



public struct GLDepthClearMask : GLClearMask {
	
	public let bitmask : Int32 = GL_DEPTH_BUFFER_BIT
	
	public var value : GLclampd = 1
	
	public init () {}
	
	public init (_ depth: GLclampd) {
		value = depth
	}
	
	public func clear () {
		glClearDepth(value)
	}
}


public struct GLStencilClearMask : GLClearMask {
	
	public let bitmask : Int32 = GL_STENCIL_BUFFER_BIT
	
	public var value : Int = 0
	
	public init () {}
	
	public init (_ stencil: Int) {
		value = stencil
	}
	
	public func clear () {
		glClearStencil(0)
	}
}