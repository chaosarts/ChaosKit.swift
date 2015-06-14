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
	
	/// Provides the light color
	var color : RGBColor {get set}
	
	/// Provides the intensity
	var intensity : GLfloat {get set}
	
	/// Provides a map of light property types
	var uniforms : [GLUrl : GLUniform] {get}
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
	internal var _uniforms : [GLUrl : GLUniform]?
	
	/// Provides the state of light
	public var state : GLLightState = ON
	
	/// Provides the light color
	public var color : RGBColor = (1, 1, 1)
	
	/// Provides the lights intensity
	public var intensity : GLfloat = 1
}