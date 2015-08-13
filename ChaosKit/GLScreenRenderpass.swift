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
		applyHints()
		clear()
		
		if camera.stage == nil {
			println("No stage set for camera.")
			return
		}
		
		var uniforms : [GLurl : GLUniform] = camera.uniforms
		for url in uniforms.keys {
			var location : GLuniformloc? = program.getUniformLocation(url)
			
			if nil == location {continue}
			
			var uniform : GLUniform = uniforms[url]!
			uniform.assign(location!)
		}
		
		var stage : GLStage = camera.stage!
		for shape in stage.shapes {
			var uniforms : [GLurl : GLUniform] = shape.uniforms
			
			for url in uniforms.keys {
				var location : GLuniformloc? = program.getUniformLocation(url)
				var uniform : GLUniform = uniforms[url]!
				if nil == location {continue}
				uniform.assign(location!)
			}
			
			program.upload(shape.buffers)
			
			var geometry : GLGeometry = shape.geometry
			var count : GLsizei = GLsizei(geometry.indexlist.count)
			if geometry.sharedVertice {
				glDrawElements(shape.mode, count, GLenum(GL_UNSIGNED_INT), geometry.indexlist)
			}
			else {
				glDrawArrays(shape.mode, 0, count)
			}
			
			program.unload(shape.buffers)
		}
		
		glFlush()
	}
}