//
//  GLRenderPass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 04.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLRenderer {
	
	var context : NSOpenGLContext {get}
	
	var camera : GLCamera {get}
	
	var stage : GLStage {get}
	
	func render ()
}