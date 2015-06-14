//
//  GLUrl.swift
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
public struct GLUrl : Printable, Hashable, StringLiteralConvertible, ArrayLiteralConvertible {
	
	private static var _delimiter : Character = "."
	
	/// The attribute type
	private let _domains : [String]
	
	/// String representation of the selector
	public var description : String {
		get {return String(GLUrl._delimiter).join(_domains)}
	}
	
	/// Hashvalue representation
	public var hashValue: Int {get{return description.hashValue}}
	
	
	/**
	Initializes the url with passed domains, where index 0 is top level
	
	:param: domains
 	*/
	public init (_ domains: [String]) {
		_domains = domains
	}
	
	
	/**
	Initializes the selector with given type and domain
	
	:param: type The type name for the anonymous attribute location
	:param: domain The domain to specify the context
	*/
	public init (arrayLiteral domains: String...) {
		self.init(domains)
	}
	
	
	/**
	Initializes the url with given domain
	
	:param: domain
	:param: subdomain
	:param: subdomains
	*/
	public init (_ domain: String, _ subdomain: GLAttributeType, _ subdomains: String...) {
		self.init([domain, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initializes the url with given domain
	
	:param: domain
	:param: subdomain
	:param: subdomains
	*/
	public init (_ domain: GLUrlDomain, _ subdomain: GLAttributeType, _ subdomains: String...) {
		self.init([domain.rawValue, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initializes the url with default top level domain
	
	:param: subdomain
	:param: subdomains
 	*/
	public init (_ subdomain: GLAttributeType, _ subdomains: String...) {
		self.init([GLUrlDomain.Default.rawValue, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initializes the url with given domain
	
	:param: domain
	:param: subdomain
	:param: subdomains
	*/
	public init (_ domain: String, _ subdomain: GLUniformType, _ subdomains: String...) {
		self.init([domain, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initializes the url with given domain
	
	:param: domain
	:param: subdomain
	:param: subdomains
	*/
	public init (_ domain: GLUrlDomain, _ subdomain: GLUniformType, _ subdomains: String...) {
		self.init([domain.rawValue, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initializes the url with default top level domain
	
	:param: subdomain
	:param: subdomains
	*/
	public init (_ subdomain: GLUniformType, _ subdomains: String...) {
		self.init([GLUrlDomain.Default.rawValue, subdomain.rawValue] + subdomains)
	}
	
	
	/**
	Initalizer to assign a selecotr variable with a string literal
	
	:param: stringLiteral
	*/
	public init(stringLiteral value: String) {
		self.init(split(value, maxSplit: 1, allowEmptySlices: false, isSeparator: {(value: Character) -> Bool in return value == GLUrl._delimiter}))
	}
	
	
	/**
	Initalizer to assign a selecotr variable with a string literal
	
	:param: stringLiteral
	*/
	public init(unicodeScalarLiteral value: String) {
		self.init(stringLiteral: value)
	}
	
	
	/**
	Initalizer to assign a selecotr variable with a string literal
	
	:param: stringLiteral
	*/
	public init(extendedGraphemeClusterLiteral value: String) {
		self.init(stringLiteral: value)
	}
}


/**
Compare function for Hashable/Equatable protocol

:param: left
:param: right
:return: Returns true when the hashables has the same values
*/
public func ==(left: GLUrl, right: GLUrl) -> Bool {
	return left.description == right.description
}


public enum GLUrlDomain : String {
	case Default = "default"
	
	case Vertex = "vertex"
	case Model = "model"
	case Normal = "normal"
	case Camera = "camera"
	
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
}


public enum GLUniformType : String {
	case Transformation = "Transformation"
	case Projection = "projection"
	
	case Sampler = "sampler"
	
	case Color = "color"
	case Intensity = "intensity"
	case Shinyness = "shinyness"
}

