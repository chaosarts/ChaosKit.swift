//
//  GLVertexElementBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 03.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLVertexElementBuffer : GLShapeBufferBase, GLShapeBuffer {
	
	public init () {
		super.init (target: GL_ELEMENT_ARRAY_BUFFER)
	}
	
	public func draw () {
		
	}
}