//
//  GLBufferConfig.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct GLBufferConfig {
	
	private var _blocks : [GLBufferBlock]
	
	private var _stride : GLsizei = 0
	
	public var stride : GLsizei {get {return _stride}}
	
	public var usage : GLenum = GLenum(GL_STATIC_DRAW)
	
	public var count : Int {get {return _blocks.count}}
	
	public subscript (index: Int) -> GLBufferBlock {
		get {return _blocks[index]}
	}
	
	
	public mutating func append (inout block: GLBufferBlock) {
		block.offset = GLint(stride)
		_stride += GLsizei(block.size)
		_blocks.append(block)
	}
}
