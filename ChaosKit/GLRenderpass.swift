//
//  GLRenderpass.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 08.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/*
|--------------------------------------------------------------------------
| Renderpass protocol
|--------------------------------------------------------------------------
*/

/** 
Protocol to describe a render pass
*/
public protocol GLRenderpass {
	func execute ()
}


/*
|--------------------------------------------------------------------------
| Basic class for render passes
|--------------------------------------------------------------------------
*/

/**
Basic class
*/
public class GLRenderpassBase {
	
	/// Contains a capability map
	private var _capabilities : [GLenum : GLcapability] = [GLenum : GLcapability]()
	
	/// Contains the bitfield for clearing the buffers
	private var _clearmasks : [Int32 : GLclearmask] = [Int32 : GLclearmask]()
	
	
	public init () {}
	
	
	/** 
	Sets a clear mask for this render pass
	
	:param: mask
	*/
	public func setClear (mask: GLclearmask) {
		_clearmasks[mask.bitmask] = mask
	}
	
	
	/**
	Enables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public func enableCapabilities (caps: Int32...) {
		for cap in caps {
			_capabilities[GLenum(cap)] = GLcapability(cap, true)
		}
	}
	
	
	/**
	Disables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public func disableCapabilities (caps: Int32...) {
		for cap in caps {
			_capabilities[GLenum(cap)] = GLcapability(cap, false)
		}
	}
	
	
	/**
	Applies set rendering capabilities
	*/
	public func applyCapabilities () {
		for name in _capabilities.keys {
			_capabilities[name]?.apply()
		}
	}
	
	
	/** 
	Clears opengl buffers
	*/
	public func clear () {
		var bitmask : Int32 = 0
		
		for flag in _clearmasks.keys {
			_clearmasks[flag]?.clear()
			bitmask = bitmask | _clearmasks[flag]!.bitmask
		}
		
		if bitmask != 0 {glClear(GLbitfield(bitmask))}
	}
}