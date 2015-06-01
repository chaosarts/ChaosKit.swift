//
//  GLRenderpass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 08.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol GLRenderpass {
	var camera : GLCamera {get set}
	
	func execute ()
}

public class GLRenderpassBase {
	
	/// Contains a capability map
	private var _capabilities : [GLenum : GLCapability] = [GLenum : GLCapability]()
	
	/// Contains the bitfield for clearing the buffers
	private var _clearmasks : [Int32 : GLClearMask] = [Int32 : GLClearMask]()
	
	/// Provides the camera of the render pass
	public var camera : GLCamera = GLCamera()
	
	
	/** 
	Sets a clear mask for this render pass
	
	:param: mask
	*/
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
	
	
	/**
	Applies set rendering capabilities
	*/
	internal func _applyCapabilities () {
		for name in _capabilities.keys {
			_capabilities[name]?.apply()
		}
	}
	
	
	/** 
	Clears opengl buffers
	*/
	internal func _clear () {
		var bitmask : Int32 = 0
		
		for flag in _clearmasks.keys {
			_clearmasks[flag]?.clear()
			bitmask = bitmask | _clearmasks[flag]!.bitmask
		}
		
		if bitmask != 0 {glClear(GLbitfield(bitmask))}
	}
}