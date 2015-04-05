//
//  GLArrayBuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 01.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa


public class GLArrayBuffer : GLBuffer {
	public init () {
		super.init(target: GL_ARRAY_BUFFER)
	}
}
