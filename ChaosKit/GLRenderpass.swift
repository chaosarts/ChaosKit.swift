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
	private final var _caps : [GLenum : GLcap] = [GLenum : GLcap]()
	
	/// Provides a list of buffer writer capabilities
	private final var _bufwrites : [GLenum : GLbufwrite] = [GLenum : GLbufwrite]()
	
	/// Contains the bitfield for clearing the buffers
	private final var _clearmasks : [Int32 : GLclear] = [Int32 : GLclear]()
	
	/// Contains gl hints
	private final var _hints : [GLenum : GLenum] = [GLenum : GLenum]()
	
	/// Indicates if capability GL_BLEND is enabled or disabled
	public var blendEnabled : Bool {
		get {return nil != _caps[GLenum(GL_BLEND)] && _caps[GLenum(GL_BLEND)]!.enabled}
		set {setCapabilityEnabled(GL_BLEND, newValue)}
	}
	
	/// Indicates if capability GL_CULL_FACE is enabled or disabled
	public var cullFaceEnabled : Bool {
		get {return nil != _caps[GLenum(GL_CULL_FACE)] && _caps[GLenum(GL_CULL_FACE)]!.enabled}
		set {setCapabilityEnabled(GL_CULL_FACE, newValue)}
	}
	
	/// Indicates if capability GL_DEPTH_TEST is enabled or disabled
	public var depthTestEnabled : Bool {
		get {return nil != _caps[GLenum(GL_DEPTH_TEST)] && _caps[GLenum(GL_DEPTH_TEST)]!.enabled}
		set {setCapabilityEnabled(GL_DEPTH_TEST, newValue)}
	}
	
	/// Indicates if capability GL_LINE_SMOOTH is enabled or disabled
	public var lineSmoothEnabled : Bool {
		get {return nil != _caps[GLenum(GL_LINE_SMOOTH)] && _caps[GLenum(GL_LINE_SMOOTH)]!.enabled}
		set {setCapabilityEnabled(GL_LINE_SMOOTH, newValue)}
	}
	
	/// Indicates if capability GL_POLYGON_SMOOTH is enabled or disabled
	public var polygonSmoothEnabled : Bool {
		get {return nil != _caps[GLenum(GL_POLYGON_SMOOTH)] && _caps[GLenum(GL_POLYGON_SMOOTH)]!.enabled}
		set {setCapabilityEnabled(GL_POLYGON_SMOOTH, newValue)}
	}
	
	/// Indicates if capability GL_SCISSOR_TEST is enabled or disabled
	public var sciccorTestEnabled : Bool {
		get {return nil != _caps[GLenum(GL_SCISSOR_TEST)] && _caps[GLenum(GL_SCISSOR_TEST)]!.enabled}
		set {setCapabilityEnabled(GL_SCISSOR_TEST, newValue)}
	}
	
	/// Indicates if capability GL_STENCIL_TEST is enabled or disabled
	public var stencilTestEnabled : Bool {
		get {return nil != _caps[GLenum(GL_STENCIL_TEST)] && _caps[GLenum(GL_STENCIL_TEST)]!.enabled}
		set {setCapabilityEnabled(GL_STENCIL_TEST, newValue)}
	}

	/// Provides the hint value for line smoothness
	public var lineSmoothHint : GLenum? {
		get {return getHint(GL_LINE_SMOOTH_HINT)}
		set {setHint(GL_LINE_SMOOTH_HINT, newValue)}
	}
	
	/// Provides the hint value for polygon smoothness
	public var polygonSmoothHint : GLenum? {
		get {return getHint(GL_POLYGON_SMOOTH_HINT)}
		set {setHint(GL_POLYGON_SMOOTH_HINT, newValue)}
	}
	
	public init () {}
	
	
	/** 
	Sets a clear mask for this render pass
	
	:param: mask
	*/
	public final func setClear (mask: GLclear) {
		_clearmasks[mask.bitmask] = mask
	}
	
	
	/**
	Returns the value for the passed hint
	
	:param: hint
	*/
	public final func getHint (name: GLenum) -> GLenum? {
		return _hints[name]
	}
	
	
	/**
	Returns the value for the passed hint
	
	:param: hint
	*/
	public final func getHint (name: Int32) -> GLenum? {
		return getHint(GLenum(name))
	}
	
	
	/**
	Sets a hint for the opngl server
	
	:param: name The name of the hint
	:param: value The value for the hint
	*/
	public final func setHint (name: GLenum, _ value: GLenum?) {
		if value != nil {_hints[name] = value}
		else {_hints.removeValueForKey(name)}
	}
	
	
	public final func setHint (name: Int32, _ value: GLenum?) {
		setHint(GLenum(name), value)
	}
	
	
	public final func setHint (name: GLenum, _ value: Int32?) {
		var val : GLenum? = nil == value ? nil : GLenum(value!)
		setHint(name, val)
	}
	
	
	public final func setHint (name: Int32, _ value: Int32?) {
		var val : GLenum? = nil == value ? nil : GLenum(value!)
		setHint(GLenum(name), val)
	}
	
	
	/**
	En or disables a server-side capability
	
	:param: cap The name of the capability
	:param: enable
	*/
	public final func setCapabilityEnabled (cap: GLenum, _ enable: Bool = true) {
		_caps[GLenum(cap)] = GLcap(cap, enable)
	}
	
	
	/**
	En or disables a server-side capability
	
	:param: cap The name of the capability
	:param: enable
	*/
	public final func setCapabilityEnabled (cap: Int32, _ enable: Bool = true) {
		setCapabilityEnabled(GLenum(cap), enable)
	}
	
	
	/**
	Enables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public final func enableCapabilities (caps: Int32...) {
		for cap in caps {
			setCapabilityEnabled(GLenum(cap), true)
		}
	}
	
	
	/**
	Disables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public final func disableCapabilities (caps: Int32...) {
		for cap in caps {
			setCapabilityEnabled(GLenum(cap), false)
		}
	}
	
	
	/**
	Applies set rendering capabilities
	*/
	public final func applyCapabilities () {
		for name in _caps.keys {
			_caps[name]?.apply()
		}
	}
	
	
	public final func applyHints () {
		for hintname in _hints.keys {
			glHint(GLenum(hintname), GLenum(_hints[hintname]!))
			glPrintError_CK()
		}
	}
	
	
	/** 
	Clears opengl buffers
	*/
	public final func clear () {
		var bitmask : Int32 = 0
		
		for flag in _clearmasks.keys {
			_clearmasks[flag]?.clear()
			bitmask = bitmask | _clearmasks[flag]!.bitmask
		}
		
		if bitmask != 0 {glClear(GLbitfield(bitmask))}
	}
}