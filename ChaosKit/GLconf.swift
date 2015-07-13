//
//  File.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Renderpass struct to controll depth capabilities like depth test, write permission
to depth buffer, clear value etc
*/
public struct GLdepthconf {
	
	/// Provides the depth test capability
	private var _cap : GLcap?
	
	/// The clear value for glClearDepth
	public var clear : GLclampd = 1.0
	
	/// Provides the compare function to use for depth test. Default is GL_LESS
	public var compare : GLenum = GLenum(GL_LESS)
	
	/// Provides the mask for glDepthMask function. Must be either GL_TRUE or GL_FALSE
	public var mask : GLboolean = GLboolean(GL_TRUE)
	
	/// Provides the bitfield, which will be ORed in glClear call
	public var bitfield : GLbitfield {get {return GLbitfield(GL_DEPTH_BUFFER_BIT)}}
	
	/// En- or disables depth test
	public var enableTest : Bool {
		get {return _cap != nil || _cap!.enabled}
		set {_cap = GLcap(GLenum(GL_DEPTH_TEST), newValue)}
	}
	
	public init () {}
	
	
	public func apply () {
		_cap?.apply()
		glDepthMask(mask)
		glDepthFunc(compare)
		glClearDepth(clear)
	}
}