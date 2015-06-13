//
//  GLLocation.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 02.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/*
|--------------------------------------------------------------------------
| Location Class
|--------------------------------------------------------------------------
*/

/**
Base class for shader program locations
*/
public class GLLocation : GLBase, Printable {
	
	/// The varname string in the shader program
	public let name : String
	
	public var description : String {
		get {return "\(name) (id: \(id))"}
	}
	
	/**
	Initializes the location with passed id (index) and varname
	*/
	internal init (_ id: GLuint, _ name: String) {
		self.name = name
		super.init(id)
	}
}


/*
|--------------------------------------------------------------------------
| Location Selector
|--------------------------------------------------------------------------
*/

/**
This struct is used to select attribute locations from a GLProgram object
anonymously.
*/
public struct GLLocationSelector : Printable, StringLiteralConvertible, Hashable {
	
	private static var _delimiter : Character = "."
	
	/// Defines the domain to specialize the context
	private let _domain : String
	
	/// The attribute type
	private let _type : String
	
	/// String representation of the selector
	public var description : String {
		get {
			var suffix : String = ""
			if _domain != "" {suffix = String(GLLocationSelector._delimiter) + _domain}
			return _type + suffix
		}
	}
	
	/// Hashvalue representation
	public var hashValue: Int {get{return description.hashValue}}
	
	
	/**
	Initializes the selector with given type and domain
	
	:param: type The type name for the anonymous attribute location
	:param: domain The domain to specify the context
	*/
	public init (type: GLAttributeType, domain: String = "") {
		self.init (type: type.rawValue, domain: domain)
	}
	
	
	/**
	Initializes the selector with given type and domain
	
	:param: type The type name for the anonymous attribute location
	:param: domain The domain to specify the context
	*/
	public init (type: GLUniformType, domain: String = "") {
		self.init (type: type.rawValue, domain: domain)
	}
	
	
	/**
	Initializes the selector with given type and domain
	
	:param: type The type name for the anonymous attribute location
	:param: domain The domain to specify the context
	*/
	public init (type: String, domain: String = "") {
		_type = type
		_domain = domain
	}
	
	
	/**
	Initalizer to assign a selecotr variable with a string literal
	
	:param: stringLiteral
	*/
	public init(stringLiteral value: String) {
		var splits = split(value, maxSplit: 1, allowEmptySlices: false,
			isSeparator: {(value: Character) -> Bool in return value == GLLocationSelector._delimiter})
		if splits.count > 1 {
			self.init(type: splits[1], domain: splits[0])
		}
		else {
			self.init(type: splits[0])
		}
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
public func ==(left: GLLocationSelector, right: GLLocationSelector) -> Bool {
	return left.description == right.description
}

