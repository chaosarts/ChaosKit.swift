//
//  Default.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 04.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLDefaultRenderpass : GLRenderpass {
	
	public var program : GLProgram
	
	public var clearColor : RGBAColor = (0, 0, 0, 0)
	
	public init (program p: GLProgram) {
		program = p
	}
	
	public func render (projectionMatrix: mat4, _ modelViewMatrix: mat4, _ stage: GLStage) {
		
		program.use()
		
		glClearColor(clearColor.r, clearColor.g, clearColor.b, clearColor.a)
		glClearDepth(1)
		glClearStencil(0)
		glClear(GLenum(GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
		
		
		let uProjectionViewMatrix = program.getUniformInfo(forType: .ProjectionViewMatrix)
		
		if uProjectionViewMatrix != nil {
			glUniformMatrix4fv(uProjectionViewMatrix!.location, 1, GLboolean(GL_FALSE), toUnsafePointer(projectionMatrix.array))
		}
		
		
		let uModelViewMatrix = program.getUniformInfo(forType: .ModelViewMatrix)
		
		if uModelViewMatrix != nil {
			glUniformMatrix4fv(uModelViewMatrix!.location, 1, GLboolean(GL_FALSE), toUnsafePointer(modelViewMatrix.array))
		}
		
		
		var childQueue : CKQueue<GLDisplayObject> = CKQueue<GLDisplayObject>(stage.children)
		while !childQueue.empty {
			var child : GLDisplayObject = childQueue.dequeue()!
			if let container = child as? GLContainer {
				childQueue.enqueue(container.children)
			}
			
			if let shape = child as? GLShape {

			}
		}
	}
}