//
//  GLScreenRenderpass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GLScreenRenderpass : GLRenderpassBase, GLRenderpass {
	
	public var program : GLProgram
	
	public var camera : GLCamera = GLCamera()
	
	public init (program: GLProgram) {
		self.program = program
	}
	
	/**
	Renders the stage
	*/
	public func execute () {
		program.use()
		
		applyCapabilities()
		clear()
		
		if camera.stage == nil {
			println("No stage set for camera.")
			return
		}
		
		var uniforms : [GLUrl : GLUniform] = camera.uniforms
		for selector in uniforms.keys {
			var location : GLUniformLocation? = program.getUniformLocation(selector)
			
			if nil == location {continue}
			
			var uniform : GLUniform = uniforms[selector]!
			uniform.assign(location!)
		}
		
		var stage : GLStage = camera.stage!
		for shape in stage.shapes {
			program.draw(shape)
		}
		
		glFlush()
	}
}