//
//  ShadowMapper.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 04.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLShadowmapRenderpass : GLOffscreenRenderpass {
	
	public var program : GLProgram
	
	public var texture : GLTexture
	
	public init (program p: GLProgram, frame: NSRect) {
		program = p
		texture = GLTexture(target: GL_TEXTURE_2D)
	}
	
	public func render (projectionMatrix: mat4, _ modelViewMatrix: mat4, _ stage: GLStage) {
		glColorMask(0, 0, 0, 0)

	}
}