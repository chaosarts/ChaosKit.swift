//
//  GLRenderer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 10.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol GLRenderer {
	func render (program: GLProgram, shape: GLShape)
}


public class GLDefaultRenderer {
	public func render (program: GLProgram, shape: GLShape) {
		
	}
}