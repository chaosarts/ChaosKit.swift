//
//  GLBufferConfig.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct GLBufferConfig {
	
	private var _interleavedBlocks : [GLBufferBlock] = []
	
	private var _separatedBlocks : [GLBufferBlock] = []
	
	private var _stride : GLint
	
	public var stride : GLint {get{return _stride}}
	
	public var interleavedBlocks : [GLBufferBlock] {get {return _interleavedBlocks}}
	
	public var separatedBlocks : [GLBufferBlock] {get {return _separatedBlocks}}
	
	public mutating func addBlock (block: GLBufferBlock, interleave: Bool = true) {
		var b : GLBufferBlock = block
		if interleave {
			b.offset = _stride
			_stride += b.size
			_interleavedBlocks.append(b)
		}
		else {
			_separatedBlocks.append(block)
		}
	}
}
