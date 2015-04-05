//
//  GLRenderPass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 04.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol GLRenderpass {
	
	var program : GLProgram {get}
	
	func render (projectionMatrix: mat4, _ modelViewMatrix: mat4, _ stage: GLStage)
}


public protocol GLOffscreenRenderpass : GLRenderpass {
	
	var texture : GLTexture {get}
}