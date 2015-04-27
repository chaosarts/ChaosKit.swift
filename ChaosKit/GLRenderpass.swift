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
		_prepare()
	}
	
	
	/**
	Renders the stage
	*/
	public func render () {
		program.use()
	}
	
	
	/**
	Enables clear masks
	*/
	public func enableClear (masks: Int32...) {
		for mask in masks {
			_clearBitMask[mask] = true
		}
	}
	
	
	/**
	Disables clear masks
	*/
	public func disableClear (masks: Int32...) {
		for mask in masks {
			_clearBitMask[mask] = false
		}
	}
	
	
	/**
	Enables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public func enableCapabilities (caps: Int32...) {
		for cap in caps {
			_capabilities[GLenum(cap)] = true
		}
	}
	
	
	/**
	Disables a server-side GL capabilities
	
	:param: cap The capability name as Int32
	*/
	public func disableCapabilities (caps: Int32...) {
		for cap in caps {
			_capabilities[GLenum(cap)] = false
		}
	}
	
	private func _prepare () {
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
}