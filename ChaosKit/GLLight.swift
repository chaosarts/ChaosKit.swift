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
	var color : vec3 {get set}
	
	/// The type of the light
	var type : GLLightType {get}
	
	/// Provides a map of light property types
	var uniforms : [GLLightPropertyType : GLUniform] {get}
}


/*
|--------------------------------------------------------------------------
| Base Class
|--------------------------------------------------------------------------
*/

/**
Represents a light in opengl
*/
@objc public class GLLightBase : GLDisplayObject {
	
	/// Provides a map of light property types
	internal var _uniforms : [GLLightPropertyType : GLUniform] = [GLLightPropertyType : GLUniform]()
	
	/// Provides the state of light
	public var state : GLLightState = ON
	
	/// Provides the light color
	public var color : vec3 = vec3(1, 1, 1) {
		didSet{_uniforms[.Color] = GLUniform3f(color.x, color.y, color.z)}
	}
	
	/// Provides a map of light property types
	public var uniforms : [GLLightPropertyType : GLUniform] {get {return _uniforms}}
}


/*
|--------------------------------------------------------------------------
| Structs
|--------------------------------------------------------------------------
*/

/**
Light property data type
*/
public struct GLLightProperty {
	
	/// Opaque value of the property
	public var value : GLUniform
	
	public var type : GLLightPropertyType
	
	/// Initializes the property
	public init (type: GLLightPropertyType, value: GLUniform) {
		self.value = value
		self.type = type
	}
}


/*
|--------------------------------------------------------------------------
| Enumerations
|--------------------------------------------------------------------------
*/

/**
Enumeration of light types
*/
public enum GLLightType : String {
	case Ambient = "Ambient"
	case Diffuse = "Diffuse"
	case Specular = "Specular"
}


/**
Enumeration of light types
*/
public enum GLLightPropertyType : String {
	case Color = "Color"
	case Position = "Position"
	case Intensity = "Intensity"
	case Shinyness = "Shinyness"
}