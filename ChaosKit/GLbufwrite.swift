//
//  GLbufcap.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 19.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/** 
Protocol to describe a buffer write capability. Can be passed to 
a renderpass. When executing renderpass setEnable() will be called
*/
public protocol GLbufwrite {
	
	/// Provides the write mask type (e.g. GL_DEPTH_WRITEMASK) for glGet()
	var type : GLenum {get}
	
	/** Applies the capability by calling the according gl*Mask()-Function */
	func apply()
}


/**
Depth buffer write capability.
*/
public struct GLdepthwrite {
	
	/// Provides the write mask type (e.g. GL_DEPTH_WRITEMASK) for glGet()
	public let type : GLenum = GLenum(GL_DEPTH_WRITEMASK)
	
	/// Indicates if the buffer writer is en- or disabled
	public var flag : GLboolean
	
	/** 
	Initilaizes the buffer writer capability with passed flag
	
	:param: flag To enable or disable buffer writer
	*/
	public init (_ flag: Bool) {
		self.flag = GLboolean(flag ? GL_TRUE : GL_FALSE)
	}
	
	/** Applies the capability by calling the according gl*Mask()-Function */
	public func apply () {
		glDepthMask(flag)
	}
}


/**
Stencil buffer write capability.
*/
public struct GLstencilwrite {
	
	/// Provides the write mask type (e.g. GL_DEPTH_WRITEMASK) for glGet()
	public let type : GLenum = GLenum(GL_STENCIL_WRITEMASK)
	
	/// Indicates if the buffer writer is en- or disabled
	public var mask : GLuint
	
	/**
	Initilaizes the buffer writer capability with passed flag
	
	:param: flag To enable or disable buffer writer
	*/
	public init (_ mask: GLuint) {
		self.mask = mask
	}
	
	/** Applies the capability by calling the according gl*Mask()-Function */
	public func apply () {
		glStencilMask(mask)
	}
}


/**
Color buffer write capability.
*/
public struct GLcolorwrite {
	
	/// Provides the write mask type
	public let type : GLenum = GLenum(GL_COLOR_WRITEMASK)
	
	/// Indicates if the buffer writer is en- or disabled for red component
	public var r : GLboolean
	
	/// Indicates if the buffer writer is en- or disabled for green component
	public var g : GLboolean
	
	/// Indicates if the buffer writer is en- or disabled for blue component
	public var b : GLboolean
	
	/// Indicates if the buffer writer is en- or disabled for alpha component
	public var a : GLboolean
	
	/**
	Initilaizes the buffer writer capability with passed color code
	
	:param: red Indicates if color buffer writer is en- or disabled for red component
	:param: green Indicates if color buffer writer is en- or disabled for green component
	:param: blue Indicates if color buffer writer is en- or disabled for blue component
	:param: alpha Indicates if color buffer writer is en- or disabled for alpha component
	*/
	public init (_ red: Bool, _ green: Bool, _ blue: Bool, _ alpha: Bool) {
		r = GLboolean(red ? GL_TRUE : GL_FALSE)
		g = GLboolean(green ? GL_TRUE : GL_FALSE)
		b = GLboolean(blue ? GL_TRUE : GL_FALSE)
		a = GLboolean(alpha ? GL_TRUE : GL_FALSE)
	}
	
	/** Applies the capability by calling the according gl*Mask()-Function */
	public func apply () {
		glColorMask(r, g, b ,a)
	}
}