//
//  GLScreenRenderpass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GLScreenRenderpass : GLRenderpassBase, GLRenderpass {
	/**
	Renders the stage
	*/
	public func execute () {
		if camera.stage == nil {
			log("Camera has no stage yet.")
			return
		}
		
		program.link()
		program.use()
		
		_prepare()
		
		var stage : GLStage = camera.stage!
		var queue : CKQueue<GLDisplayObject> = CKQueue<GLDisplayObject>(stage.children)
		
		var projection : GLUniformLocation? = program.getUniformLocation(.ProjectionViewMatrix)
		projection?.assign(camera.projection.viewMatrix)
		
		while !queue.empty {
			var child : GLDisplayObject = queue.dequeue()!
			
			if let container = child as? GLContainer {
				queue.enqueue(container.children)
			}
			
			if let shape = child as? GLShape {
				shape.draw(program)
			}
		}
		
		glFlush()
	}

}