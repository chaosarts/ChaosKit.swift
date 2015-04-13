//
//  GLFboRenderpass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLFboRenderpass : GLRenderpassBase, GLRenderpass {
	
	public var texture : GLTexture
	
	public var framebuffer : GLFrameBuffer
	
	public init (program: GLProgram, texture: GLTexture) {
		self.texture = texture
	}
	
	
	public override func render() {
		
	}
}