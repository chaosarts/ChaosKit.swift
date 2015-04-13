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
	var program : GLProgram {get set}
	
	var config : GLRenderpassConfig {get set}
	
	var camera : GLCamera {get set}
}

public class GLRenderpassBase {
	
	/// Contains the render pass config for clear
	public var config : GLRenderpassConfig
	
	/// The GLProgram to use for rendering
	public var program : GLProgram
	
	/// The camera to use for renderpass
	public var camera : GLCamera = GLCamera()
	
	
	/**
	Initializes the render pass with an gl program
	
	:param: program The program to use for this render pass
	*/
	public init (program: GLProgram, config: GLRenderpassConfig) {
		self.program = program
		self.config = config
	}
	
	
	public convenience init (program: GLProgram) {
		self.init(program: program, config: GLRenderpassConfig())
	}
	
	
	/**
	Renders the stage
	*/
	public func render () {
		program.use()
		config.apply()
		
		var projectionVar : GLUniformVariable? = program[.ProjectionViewMatrix]
		if projectionVar != nil {
			glUniformMatrix4fv(GLint(projectionVar!.id), GLsizei(1), GLboolean(GL_FALSE), toUnsafePointer(camera.projection.viewMatrix.array))
		}
		
		var children : CKQueue<GLDisplayObject> = CKQueue<GLDisplayObject>(camera.stage.children)
		while !children.empty {
			var child : GLDisplayObject = children.dequeue()!
			if let container = child as? GLContainer {
				children.enqueue(container.children)
			}
			
			if let shape = child as? GLShape {
				
			}
		}
	}
}