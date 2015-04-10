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
	
	private var _texture : GLTexture?
	
	public var program : GLProgram
	
	public var renderToTexture : Bool = true
	
	public var texture : GLTexture? {get {return _texture}}
	
	public init (program: GLProgram) {
		self.program = program
	}
	
	
	public func execute (camera: GLCamera, stage: GLStage) {
		var texture : GLTexture2D = GLTexture2D(0, GL_DEPTH_COMPONENT, 1024, 1024, 0, GL_DEPTH_COMPONENT, GL_FLOAT, nil)
		
		texture.bind()
		texture.create()
		texture.parameteri(GL_TEXTURE_MIN_FILTER, GL_LINEAR)
		texture.parameteri(GL_TEXTURE_MAG_FILTER, GL_LINEAR)
		texture.parameteri(GL_TEXTURE_WRAP_S, GL_CLAMP_TO_BORDER)
		texture.parameteri(GL_TEXTURE_WRAP_T, GL_CLAMP_TO_BORDER)
		
		_framebuffer.bind()
		_framebuffer.texture2d(texture, target: GL_DRAW_FRAMEBUFFER, attachment: GL_DEPTH_ATTACHMENT, level: 0)
		glDrawBuffer(GLenum(GL_NONE))
		glReadBuffer(GLenum(GL_NONE))
		
				
		_framebuffer.unbind()
		_texture = texture
	}
}