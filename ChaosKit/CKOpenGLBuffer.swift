//
//  CKOpenGLBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 16.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct CKOpenGLBuffer {
	
	private var _buffers : [CKOpenGLBaseAttributeType : GLint] = [CKOpenGLBaseAttributeType : GLint]()
	
	public init (types: CKOpenGLBaseAttributeType...) {
	
	}
	
	public init (keys: [CKOpenGLBaseAttributeType]) {
		
	}
}


extension CKOpenGLBuffer : ArrayLiteralConvertible {
	public init(arrayLiteral elements: CKOpenGLBaseAttributeType...) {
		
	}
}