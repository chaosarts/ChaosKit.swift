//
//  GLRenderpass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 08.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol GLRenderpass {
	
	/// The GLProgram to use for rendering
	var program : GLProgram {get}
	
	/// Indicates if the render pass shall render to screen
	/// or framebuffer
	var renderToTexture : Bool {get set}
	
	/// If renderToTexture is true, than result is rendered to this
	/// texture
	var texture : GLTexture? {get}
	
	func execute (camera: GLCamera, stage: GLStage)
}