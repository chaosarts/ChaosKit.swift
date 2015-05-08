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
	
	var camera : GLCamera {get set}
}

public class GLRenderpassBase {
	
	/// Contains a capability map
	private var _capabilities : [GLenum : GLCapability] = [GLenum : GLCapability]()
	
	/// Contains the bitfield for clearing the buffers
	private var _clearmasks : [Int32 : GLClearMask] = [Int32 : GLClearMask]()
	
	/// The GLProgram to use for rendering
	public var program : GLProgram
	
	/// The camera to use for renderpass
	public var camera : GLCamera = GLCamera()
	
	
	/**
	Initializes the render pass with an gl program
	
	:param: program The program to use for this render pass
	*/
	public init (program: GLProgram) {
		self.program = program
	}
	
	
	/**
	Renders the stage
	*/
	public func render () {
		program.use()
		_prepare()
		
		var stage : GLStage = camera.stage
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
	}
	
	
	public func setClear (mask: GLClearMask) {
		_clearmasks[mask.bitmask] = mask
	}
	
	
	/**
	Enables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public func enableCapabilities (caps: Int32...) {
		for cap in caps {
			_capabilities[GLenum(cap)] = GLCapability(cap, true)
		}
	}
	
	
	/**
	Disables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public func disableCapabilities (caps: Int32...) {
		for cap in caps {
			_capabilities[GLenum(cap)] = GLCapability(cap, false)
		}
	}
	
	private func _prepare () {
		for name in _capabilities.keys {
			_capabilities[name]?.apply()
		}
		
		var bitmask : Int32 = 0
		for flag in _clearmasks.keys {
			_clearmasks[flag]?.clear()
			bitmask = bitmask | _clearmasks[flag]!.bitmask
		}
		
		if bitmask != 0 {glClear(GLbitfield(bitmask))}
	}
}