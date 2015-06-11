//
//  GLLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public typealias GLLightState = Bool
public let ON : GLLightState = true
public let OFF : GLLightState = true

public protocol GLLight {
	/// Provides the state of light
	var state : GLLightState {get set}
	
	/// The type of the light
	var type : GLLightType {get}
	
	/// Provides a map of light property types
	var uniforms : [GLLightPropertyType : GLUniform] {get}
}

/**
Represents a light in opengl
*/
public class GLLightBase : GLDisplayObject {
	
	/// Provides a map of light property types
	internal var _uniforms : [GLLightPropertyType : GLUniform] = [GLLightPropertyType : GLUniform]()
	
	/// The type of the light
	internal var _type : GLLightType = .Ambient
	
	/// The type of the light
	public var type : GLLightType {get {return _type}}
	
	/// Provides the state of light
	public var state : GLLightState = ON
	
	/// Provides a map of light property types
	public var uniforms : [GLLightPropertyType : GLUniform] {get {return _uniforms}}
}

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
	case Position = "Position"
	case Intensity = "Intensity"
	case Shinyness = "Shinyness"
}