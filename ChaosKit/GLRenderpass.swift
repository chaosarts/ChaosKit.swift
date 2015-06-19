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
	private var _capabilities : [GLenum : GLcap] = [GLenum : GLcap]()
	
	/// Contains the bitfield for clearing the buffers
	private var _clearmasks : [Int32 : GLclear] = [Int32 : GLclear]()
	
	/// Contains gl hints
	private var _hints : [Int32 : Int32] = [Int32 : Int32]()
	
	public var lineSmooth : Int32? {
		get {return _hints[GL_LINE_SMOOTH_HINT]}
		set {setHint(GL_LINE_SMOOTH_HINT, value: newValue)}
	}
	
	public var polygonSmooth : Int32? {
		get {return _hints[GL_POLYGON_SMOOTH_HINT]}
		set {setHint(GL_POLYGON_SMOOTH_HINT, value: newValue)}
	}
	
	public init () {}
	
	
	/** 
	Sets a clear mask for this render pass
	
	:param: mask
	*/
	public func setClear (mask: GLclear) {
		_clearmasks[mask.bitmask] = mask
	}
	
	/**
	*/
	public func setHint (name: Int32, value: Int32?) {
		if value != nil {_hints[name] = value}
		else {_hints.removeValueForKey(name)}
	}
	
	
	/**
	Enables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public func enableCapabilities (caps: Int32...) {
		for cap in caps {
			_capabilities[GLenum(cap)] = GLcap(cap, true)
		}
	}
	
	
	/**
	Disables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public func disableCapabilities (caps: Int32...) {
		for cap in caps {
			_capabilities[GLenum(cap)] = GLcap(cap, false)
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
	
	
	public func applyHints () {
		for hintname in _hints.keys {
			glHint(GLenum(hintname), GLenum(_hints[hintname]!))
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