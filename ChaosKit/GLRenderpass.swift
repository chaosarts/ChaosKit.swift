//
//  GLRenderpass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 06.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/** 
Describes the 'interface' for a render pass
*/
public protocol GLRenderpass {
	
	/// The program to use for the render pass
	var program : GLProgram {get}
	
	
	/** 
	Executes the render pass
	
	:param: camera The user camera that looks at the stage as it is shown on the real screen
	:param: stage The stage on which the camera looks at
	*/
	func execute (camera: GLCamera, stage: GLStage)
}