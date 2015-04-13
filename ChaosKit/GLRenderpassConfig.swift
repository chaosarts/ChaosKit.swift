//
//  GLRenderpassConfig.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct GLRenderpassConfig {
	
	/// Contains a capability map
	private var _capabilities : [GLenum : Bool] = [GLenum : Bool]()
	
	/// Contains the bitfield for clearing the buffers
	private var _clearBitMask : [Int32 : Bool] = [Int32 : Bool]()
	
	/// Contains the color, with which to clear
	public var clearColor : RGBAColor = (0, 0, 0, 0)
	
	/// Contains the depth value to clear
	public var clearDepth : Double = 1.0
	
	/// Contains the stencil value to clear
	public var clearStencil : Int = 0
	
	public func apply () {
		for name in _capabilities.keys {
			var enabled : Bool = _capabilities[name]!
			if enabled {glEnable(name)}
			else {glDisable(name)}
		}
		
		
		if _clearBitMask[GL_COLOR_BUFFER_BIT] != nil {
			glClearColor(clearColor.r, clearColor.g, clearColor.b, clearColor.a)
		}
		
		if _clearBitMask[GL_STENCIL_BUFFER_BIT] != nil {
			glClearStencil(GLint(clearStencil))
		}
		
		if _clearBitMask[GL_DEPTH_BUFFER_BIT] != nil {
			glClearDepth(GLclampd(clearDepth))
		}
		
		
		var mask : Int32 = 0
		for name in _clearBitMask.keys {
			var enabled : Bool = _clearBitMask[name]!
			if !enabled {continue}
			mask = mask | name
		}
		
		if mask != 0 {glClear(GLbitfield(mask))}
	}
	
	
	/**
	Enables clear masks
	*/
	public mutating func enableClear (masks: Int32...) {
		for mask in masks {
			_clearBitMask[mask] = true
		}
	}
	
	
	/**
	Disables clear masks
	*/
	public mutating func disableClear (masks: Int32...) {
		for mask in masks {
			_clearBitMask[mask] = false
		}
	}
	
	
	/**
	Enables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public mutating func enableCapabilities (caps: Int32...) {
		for cap in caps {
			_capabilities[GLenum(cap)] = true
		}
	}
	
	
	/**
	Disables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public mutating func disableCapabilities (caps: Int32...) {
		for cap in caps {
			_capabilities[GLenum(cap)] = false
		}
	}
}