//
//  GLclear.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 08.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL
import OpenGL.GL


/*
|--------------------------------------------------------------------------
| GLclear protocol
|--------------------------------------------------------------------------
*/

/**
Protocol to describe a clear mask. A clear mask object can be passed 
to a renderpass. The renderpass then calls clear() and involves the
bitmask in glCLear(GLenum bitmask) given by the bitmask property.

Since each clear mask has its own glClear-Function with different types
of parameter types, a own implementation for each clear mask type is
needed.
*/
public protocol GLclear {
	
	/// Provides the clear mask
	var bitmask : Int32 {get}
	
	/// Calls the according glClear* function
	func clear ()
}


/*
|--------------------------------------------------------------------------
| GLclear protocol implementations
|--------------------------------------------------------------------------
*/

/**
Clearmask struct implementing GLclear to clear color buffer bit.
*/
public struct GLcolclear : GLclear {
	
	/// Provides the clear mask
	public let bitmask : Int32 = GL_COLOR_BUFFER_BIT
	
	/// Provides the value to use for clear function
	public var value : RGBAColor
	
	
	/** 
	Initializes the color mask with given color code
	
	:param: color The color to use for color clear
	*/
	public init (_ color: RGBAColor) {
		value = color
	}
	
	
	/** Initializes the color mask with black */
	public init () {
		self.init((0, 0, 0, 0))
	}
	
	
	/**
	Initializes the color mask with given color code
	
	:param: r The red component of the color code
	:param: g The green component of the color code
	:param: b The blue component of the color code
	:param: a The alpha component of the color code
	*/
	public init (_ r: GLfloat, _ g: GLfloat, _ b: GLfloat, _ a: GLfloat) {
		self.init ((r, g, b, a))
	}
	
	/** Calls the glClearColor() function with set color code */
	public func clear () {
		glClearColor(value.r, value.g, value.b, value.a)
	}
}


/**
Clearmask struct implementing GLclear to clear depth buffer bit.
*/
public struct GLdepthclear : GLclear {
	
	/// Provides the clear mask
	public let bitmask : Int32 = GL_DEPTH_BUFFER_BIT
	
	/// The clear value
	public var value : GLclampd
	
	
	/**
	Initializes the clear mask with passed depth value
	
	:param: depth The depth value to clear
	*/
	public init (_ depth: GLclampd) {
		value = depth
	}
	
	/** Initializes the clear mask with default value 1.0 */
	public init () {
		self.init(1)
	}
	
	/** Calls the glClearDepth() function with set depth value */
	public func clear () {
		glClearDepth(value)
	}
}


/**
Clearmask struct implementing GLclear to clear stencil buffer bit.
*/
public struct GLstencilclear : GLclear {
	
	/// Provides the clear mask
	public let bitmask : Int32 = GL_STENCIL_BUFFER_BIT
	
	/// The clear value
	public var value : Int = 0

	
	/**
	Initializes the clear mask with passed depth value
	
	:param: stencil The depth value to clear
	*/
	public init (_ stencil: Int) {
		value = stencil
	}
	
	/** Initializes the clear mask with default value 0 */
	public init () {
		self.init (0)
	}
	
	/** Calls the glClearStencil() function with set stencil value */
	public func clear () {
		glClearStencil(0)
	}
}