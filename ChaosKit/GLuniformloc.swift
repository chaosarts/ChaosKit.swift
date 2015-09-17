//
//  GLUniform.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL


/**
Struct that holds information about a uniform location within a program
*/
public struct GLuniformloc : GLLocation {
	
	/// The variable name of the uniform
	public let name : String
	
	/// The location index of the uniform
	public let index : GLuint
	
	/// The description of the uniform
	public var description : String {
		get {return "\(name) (index: \(index))"}
	}
	
	/**
	Initializes the uniform location with the index and name
	
	- parameter index: The index of the uniform
	- parameter name: The name of the uniform
	*/
	public init (index: GLuint, name: String) {
		self.name = name
		self.index = index
	}
	
	/**
	Assigns a 
	*/
	public func assign (value: GLUniform) {
		value.assign(self)
	}
}