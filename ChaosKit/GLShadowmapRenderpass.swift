//
//  GLLightmapRenderpass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 06.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLShadowmapRenderpass : GLRenderpass {
	
	private var _framebuffer : GLFrameBuffer = GLFrameBuffer()
	
	public var program : GLProgram
	
	public var size : Sizei = Sizei(1024, 1024)
	
	
	public init (program: GLProgram) {
		self.program = program
	}
	
	
	public func execute (camera: GLCamera, stage: GLStage) {
		var texture : GLTexture2D = GLTexture2D(size)
		
		texture.bind()
		texture.create(GL_DEPTH_COMPONENT, GL_DEPTH_COMPONENT, GL_FLOAT, nil)
		texture.parameteri(GL_TEXTURE_MIN_FILTER, GL_LINEAR)
		texture.parameteri(GL_TEXTURE_MAG_FILTER, GL_LINEAR)
		texture.parameteri(GL_TEXTURE_WRAP_S, GL_CLAMP_TO_BORDER)
		texture.parameteri(GL_TEXTURE_WRAP_T, GL_CLAMP_TO_BORDER)
		
		_framebuffer.bind()
		_framebuffer.texture2d(texture, target: GL_DRAW_FRAMEBUFFER, attachment: GL_DEPTH_ATTACHMENT, level: 0)
		glDrawBuffer(GLenum(GL_NONE))
		glReadBuffer(GLenum(GL_NONE))
		
				
		_framebuffer.unbind()
	}
}