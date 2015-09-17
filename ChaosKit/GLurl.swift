//
//  GLurl.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 14.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/*
|--------------------------------------------------------------------------
| Location Selector
|--------------------------------------------------------------------------
*/

/**
This struct is used to select attribute locations from a GLProgram object
anonymously.
*/
public struct GLurl : CustomStringConvertible, Hashable, StringLiteralConvertible, ArrayLiteralConvertible {
	
	private static var _delimiter : Character = "."
	
	/// The attribute type
	private let _domains : [String]
	
	/// String representation of the url
	public var description : String {
		get {return _domains.joinWithSeparator(String(GLurl._delimiter))}
	}
	
	/// Hashvalue representation
	public var hashValue: Int {get{return description.hashValue}}
	
	
	/**
	Initializes the url with passed domains, where index 0 is top level
	
	- parameter domains:
 	*/
	public init (_ domains: [String]) {
		_domains = domains
	}
	
	
	/**
	Initializes the url with given type and domain
	
	- parameter type: The type name for the anonymous attribute location
	- parameter domain: The domain to specify the context
	*/
	public init (arrayLiteral domains: String...) {
		self.init(domains)
	}
	
	
	/**
	Initializes the url with given domain
	
	- parameter domain:
	- parameter subdomain:
	- parameter subdomains:
	*/
	public init (_ domain: String, _ subdomain: GLAttributeType, _ subdomains: String...) {
		self.init([domain, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initializes the url with given domain
	
	- parameter domain:
	- parameter subdomain:
	- parameter subdomains:
	*/
	public init (_ domain: GLUrlDomain, _ subdomain: GLAttributeType, _ subdomains: String...) {
		self.init([domain.rawValue, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initializes the url with default top level domain
	
	- parameter subdomain:
	- parameter subdomains:
 	*/
	public init (_ subdomain: GLAttributeType, _ subdomains: String...) {
		self.init([GLUrlDomain.Default.rawValue, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initializes the url with given domain
	
	- parameter domain:
	- parameter subdomain:
	- parameter subdomains:
	*/
	public init (_ domain: String, _ subdomain: GLUniformType, _ subdomains: String...) {
		self.init([domain, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initializes the url with given domain
	
	- parameter domain:
	- parameter subdomain:
	- parameter subdomains:
	*/
	public init (_ domain: GLUrlDomain, _ subdomain: GLUniformType, _ subdomains: String...) {
		self.init([domain.rawValue, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initializes the url with default top level domain
	
	- parameter subdomain:
	- parameter subdomains:
	*/
	public init (_ subdomain: GLUniformType, _ subdomains: String...) {
		self.init([GLUrlDomain.Default.rawValue, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initalizer to assign a selecotr variable with a string literal
	
	- parameter stringLiteral:
	*/
	public init(stringLiteral value: String) {
		self.init(value.characters.split(1, allowEmptySlices: false, isSeparator: {(value: Character) -> Bool in return value == GLurl._delimiter}).map { String($0) })
	}
	
	
	/**
	Initalizer to assign a selecotr variable with a string literal
	
	- parameter stringLiteral:
	*/
	public init(unicodeScalarLiteral value: String) {
		self.init(stringLiteral: value)
	}
	
	
	/**
	Initalizer to assign a selecotr variable with a string literal
	
	- parameter stringLiteral:
	*/
	public init(extendedGraphemeClusterLiteral value: String) {
		self.init(stringLiteral: value)
	}
}


/**
Compare function for Hashable/Equatable protocol

- parameter left:
- parameter right:
:return: Returns true when the hashables has the same values
*/
public func ==(left: GLurl, right: GLurl) -> Bool {
	return left.description == right.description
}


public enum GLUrlDomain : String {
	case Default = "default"
	
	case Vertex = "vertex"
	case Model = "model"
	case Normal = "normal"
	case Camera = "camera"
	case Surface = "surface"
	
	case AmbientLight = "ambientlight"
	case DiffuseLight = "diffuselight"
	case SpecularLight = "specularlight"
	
	case ColorMap = "colormap"
	case DiffuseMap = "diffusemap"
	case NormalMap = "normalmap"
	case BumpMap = "bumpmap"
	case HeightMap = "heightmap"
	case DisplacementMap = "displacementmap"
	case SpecularMap = "specularmap"
	case GlowMap = "glowmap"
}

public enum GLAttributeType : String {
	case Position = "position"
	case Normal = "normal"
	case Color = "color"
	case TexCoord = "texcoord"
	case Tangent = "tangent"
	case Bitangent = "bitangent"
}


public enum GLUniformType : String {
	case Transformation = "transformation"
	case Projection = "projection"
	
	case Sampler = "sampler"
	case Enabled = "enabled"
	
	case Intensity = "intensity"
	case Reflection = "reflection"
	case PhongExp = "phongexp"
	case Direction = "direction"
}



public let GLUrlVertexPosition : GLurl = GLurl(.Vertex, .Position)
public let GLUrlVertexNormal : GLurl = GLurl(.Vertex, .Normal)
public let GLUrlSurfaceColor : GLurl = GLurl(.Vertex, .Color)
public let GLUrlSurfaceReflection : GLurl = GLurl(.Surface, .Reflection)

public let GLUrlColorMapTexCoord : GLurl = GLurl(.ColorMap, .TexCoord)
public let GLUrlDiffuseMapTexCoord : GLurl = GLurl(.DiffuseMap, .TexCoord)
public let GLUrlNormalMapTexCoord : GLurl = GLurl(.NormalMap, .TexCoord)
public let GLUrlBumpMapTexCoord : GLurl = GLurl(.BumpMap, .TexCoord)
public let GLUrlHeightMapTexCoord : GLurl = GLurl(.HeightMap, .TexCoord)
public let GLUrlDisplacementMapTexCoord : GLurl = GLurl(.DisplacementMap, .TexCoord)
public let GLUrlSpecularMapTexCoord : GLurl = GLurl(.SpecularMap, .TexCoord)
public let GLUrlGlowMapTexCoord : GLurl = GLurl(.GlowMap, .TexCoord)

public let GLUrlColorMapTangent : GLurl = GLurl(.ColorMap, .Tangent)
public let GLUrlDiffuseMapTangent : GLurl = GLurl(.DiffuseMap, .Tangent)
public let GLUrlNormalMapTangent : GLurl = GLurl(.NormalMap, .Tangent)
public let GLUrlBumpMapTangent : GLurl = GLurl(.BumpMap, .Tangent)
public let GLUrlHeightMapTangent : GLurl = GLurl(.HeightMap, .Tangent)
public let GLUrlDisplacementMapTangent : GLurl = GLurl(.DisplacementMap, .Tangent)
public let GLUrlSpecularMapTangent : GLurl = GLurl(.SpecularMap, .Tangent)
public let GLUrlGlowMapTangent : GLurl = GLurl(.GlowMap, .Tangent)

public let GLUrlColorMapBitangent : GLurl = GLurl(.ColorMap, .Bitangent)
public let GLUrlDiffuseMapBitangent : GLurl = GLurl(.DiffuseMap, .Bitangent)
public let GLUrlNormalMapBitangent : GLurl = GLurl(.NormalMap, .Bitangent)
public let GLUrlBumpMapBitangent : GLurl = GLurl(.BumpMap, .Bitangent)
public let GLUrlHeightMapBitangent : GLurl = GLurl(.HeightMap, .Bitangent)
public let GLUrlDisplacementMapBitangent : GLurl = GLurl(.DisplacementMap, .Bitangent)
public let GLUrlSpecularMapBitangent : GLurl = GLurl(.SpecularMap, .Bitangent)
public let GLUrlGlowMapBitangent : GLurl = GLurl(.GlowMap, .Bitangent)

public let GLUrlColorMapSampler : GLurl = GLurl(.ColorMap, .Sampler)
public let GLUrlDiffuseMapSampler : GLurl = GLurl(.DiffuseMap, .Sampler)
public let GLUrlNormalMapSampler : GLurl = GLurl(.NormalMap, .Sampler)
public let GLUrlBumpMapSampler : GLurl = GLurl(.BumpMap, .Sampler)
public let GLUrlHeightMapSampler : GLurl = GLurl(.HeightMap, .Sampler)
public let GLUrlDisplacementMapSampler : GLurl = GLurl(.DisplacementMap, .Sampler)
public let GLUrlSpecularMapSampler : GLurl = GLurl(.SpecularMap, .Sampler)
public let GLUrlGlowMapSampler : GLurl = GLurl(.GlowMap, .Sampler)

public let GLUrlColorMapEnabled : GLurl = GLurl(.ColorMap, .Enabled)
public let GLUrlDiffuseMapEnabled : GLurl = GLurl(.DiffuseMap, .Enabled)
public let GLUrlNormalMapEnabled : GLurl = GLurl(.NormalMap, .Enabled)
public let GLUrlBumpMapEnabled : GLurl = GLurl(.BumpMap, .Enabled)
public let GLUrlHeightMapEnabled : GLurl = GLurl(.HeightMap, .Enabled)
public let GLUrlDisplacementMapEnabled : GLurl = GLurl(.DisplacementMap, .Enabled)
public let GLUrlSpecularMapEnabled : GLurl = GLurl(.SpecularMap, .Enabled)
public let GLUrlGlowMapEnabled : GLurl = GLurl(.GlowMap, .Enabled)

public let GLUrlAmbientLightIntensity : GLurl = GLurl(.AmbientLight, .Intensity)
public let GLUrlDiffuseLightIntensity : GLurl = GLurl(.DiffuseLight, .Intensity)
public let GLUrlDiffuseLightPosition : GLurl = GLurl(.DiffuseLight, .Position)
public let GLUrlSpecularLightIntensity : GLurl = GLurl(.SpecularLight, .Intensity)
public let GLUrlSpecularLightPosition : GLurl = GLurl(.SpecularLight, .Position)
public let GLUrlSpecularLightPhongExp : GLurl = GLurl(.SpecularLight, .PhongExp)

public let GLUrlModelViewMatrix : GLurl = GLurl(.Model, .Transformation)
public let GLUrlNormalViewMatrix : GLurl = GLurl(.Normal, .Transformation)
public let GLUrlCameraViewMatrix : GLurl = GLurl(.Camera, .Transformation)
public let GLUrlCameraProjection : GLurl = GLurl(.Camera, .Projection)
public let GLUrlCameraPosition : GLurl = GLurl(.Camera, .Position)
public let GLUrlCameraDirection : GLurl = GLurl(.Camera, .Direction)