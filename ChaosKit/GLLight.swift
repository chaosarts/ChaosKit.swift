//
//  GLLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/*
|--------------------------------------------------------------------------
| Typalias and constants
|--------------------------------------------------------------------------
*/

/// Type for light state
public typealias GLLightState = Bool

/// State to indicate that a light is on
public let ON : GLLightState = true

/// State to indicate that a light is off
public let OFF : GLLightState = false


/*
|--------------------------------------------------------------------------
| Protocols
|--------------------------------------------------------------------------
*/

/**
Protocol for lights
*/
public protocol GLLight {
	
	/// Provides the state of light
	var state : GLLightState {get set}
	
	/// Provides the intensity
	var intensity : RGBColor {get set}
	
	/// Provides a map of light property types
	var uniforms : [GLurl : GLUniform] {get}
}


/*
|--------------------------------------------------------------------------
| Base Class
|--------------------------------------------------------------------------
*/

/**
Represents a light in opengl
*/
@objc public class GLLightBase {
	
	/// Caches the uniforms
	internal var _uniforms : [GLurl : GLUniform]?
	
	/// Provides the state of light
	public var state : GLLightState = ON
	
	/// Provides the lights intensity
	public var intensity : RGBColor = (1, 1, 1)
}