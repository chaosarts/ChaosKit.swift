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
		if camera.stage == nil {return}
		
		_applyCapabilities()
		_clear()
		
		var stage : GLStage = camera.stage!
		var queue : CCQueue<GLDisplayObject> = CCQueue<GLDisplayObject>(stage.children)
		
		
		while !queue.empty {
			var child : GLDisplayObject = queue.dequeue()!
			
			if let container = child as? GLContainer {
				queue.enqueue(container.children)
			}
			
			if let shape = child as? GLShape {
				if shape.program == nil {continue}
				
				shape.program?.use()
				shape.program?.getUniformLocation(.ProjectionViewMatrix)?.assign(camera.projection.viewMatrix)
				shape.program?.draw(shape)
			}
		}
		
		glFlush()
	}

}