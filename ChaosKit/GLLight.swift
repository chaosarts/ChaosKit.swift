//
//  GLLightComponent.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/*
|--------------------------------------------------------------------------
| GLLight Typalias and Constants
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
| GLLight Class
|--------------------------------------------------------------------------
*/

public protocol GLLight {
	
}


public struct GLAmbientLight : GLLight {
	
	public var intensity : vec3 = vec3(1.0)
	
	public var coefficient : Float = 0.2
	
	public var uniforms : [GLurl : GLUniform] {
		get {return [GLUrlLightAmbientCoefficient : GLuniform1f(coefficient)]}
	}
}


public struct GLPointLight : GLLight {
	
	public var intensity : vec3 = vec3(1.0)
	
	public var position : vec3 = vec3(0.0)
	
	public var diffuse : Bool = true
	
	public var specular : Float?
	
	public var uniforms : [GLurl : GLUniform] {
		get {return [GLUrlLightAmbientCoefficient : GLuniform1f(specular!)]}
	}
	
	public init () {}
}