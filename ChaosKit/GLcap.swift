//
//  GLRenderpassCapability.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 03.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Struct to en- or disable OpenGL rendering capabilities
*/
public struct GLcap {
	
	/// Contains the capability type such as GL_DEPTH_TEST
	public let type : GLenum
	
	/// Provides either glEnable or glDisable
	private let _apply : (cap: GLenum) -> Void
	
	/**
	Initializes the capability
	
	:param: type The capability type
	:param: enable Indicates either to enable
	*/
	public init (_ type: Int32, _ enable: Bool) {
		self.type = GLenum(type)
		_apply = enable ? glEnable : glDisable
	}
	
	/**
	Applies the capability setting
	*/
	public func apply () {
		_apply(cap: type)
	}
}