//
//  GLBufferBlock.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 14.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL


/**
Sturct that hold data for a block within a buffer to serve information
to glVertexAttribPointer()
*/
public struct GLBufferBlock {
	
	/// Contains the size of the block. Must be either 1, 2, 3 or 4
	public let size : GLint
	
	/// Contains the data type of the data set (GL_FLOAT)
	public let type : GLenum
	
	/// Indicates if containing data is normalized or not
	public let normalized : Bool
	
	/// Contains the stride of the data set in the buffer
	public let stride : Int
	
	/// Provides the offset of the buffer block in bytes
	public let offset : Int
	
	public let selector : GLurl
	
	/**
	Initializes the block
	
	:param: attribute The target symbol which represents an attribute in the shader
	:param: size The size of the block per vertex. Mus be either 1, 2, 3 or 4
	*/
	public init (_ attribute: GLurl, _ size: Int, _ type : Int32, _ normalized: Bool, _ stride: Int, _ offset: Int) {
		self.selector = attribute
		self.size = GLint(size)
		self.type = GLenum(type)
		self.normalized = normalized
		self.stride = stride
		self.offset = offset
	}
}