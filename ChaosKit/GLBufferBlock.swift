//
//  GLBufferBlock.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 14.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
*/
public struct GLBufferBlock {
	
	/// Contains the size of the block. Must be either 1, 2, 3 or 4
	public let size : GLint
	
	/// Provides the target with the buffered
	public let attribute : GLAttribAlias
	
	/// Provides the offset of the buffer block in bytes
	public var offset : GLint = 0
	
	/**
	Initializes the block
	
	:param: attribute The target symbol which represents an attribute in the shader
	:param: size The size of the block per vertex. Mus be either 1, 2, 3 or 4
	*/
	public init (_ attribute: GLAttribAlias, _ size: Int) {
		self.attribute = attribute
		self.size = GLint(size)
	}
}