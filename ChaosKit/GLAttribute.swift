//
//  Attribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/*
|--------------------------------------------------------------------------
| Attribute Type Enumeration
|--------------------------------------------------------------------------
*/

/**
Enumerates the types of reasonable attributes in a vertex shader program. 
It represents a attribute variable within a cocoa program without knowing 
the name of the variable. With the help of GLAttributeInfo objects  
this a GLProgram object establishes the connection between a 
concrete variable in a shader program with this enumeration cases.

- Color: Stands for the color attribute variable
- Normal: Stands for the normal attribute variable
- Position: Stands for the position attribute variable
- TexCoord: Stands for the texture coordinate attribute variable
*/
public enum GLAttribAlias : String {
	
	/// Stands for the color attribute variable
	case Color = "Color"
	
	/// Stands for the normal attribute variable
	case Normal = "Normal"
	
	/// Stands for the position attribute variable
	case Position = "Position"
	
	/// Stands for the texture coordinate attribute variable
	case TexCoord = "TexCoord"
	
	/// Contains all cases
	static let cases : [GLAttribAlias] = [.Color, .Normal, .Position, .TexCoord]
}


/*
|--------------------------------------------------------------------------
| Attribute Info Struct
|--------------------------------------------------------------------------
*/

public struct GLAttribVariable {
	
	public let id : GLuint
	
	public let name : String
	
	public let type : GLenum
	
	public let size : GLint
	
	public init (index: GLuint, name: String, type: GLenum, size: GLint) {
		self.id = index
		self.name = name
		self.type = type
		self.size = size
	}
}

/**
This structs helps to bridge the gap between a concrete variable name in a
shader program and GLAttribAlias case. Further more consists of
known OpenGL properties, such as the symbolic attribute location, size
and name.
*/
public struct GLAttributeInfo {
	
	/// Provides the name of the attribute variable in the vertex shader of
 	/// a shader program.
	public let name : String
	
	/// Provides the attribute type/categorie in an program object
	public let target : GLAttribAlias
	
	/// Contains the data type the targeted attribute expects (GL_FLOAT, 
	/// GL_DOUBLE, etc)*/
	public var type : GLenum?
	
	/// Provides the size of the variable. If the attribute variable is an 
	/// array, this property contains the count of elements.
	public var size : GLint?
	
	/// Contains the attribute location fetched by glGetAttribLocation()
	public var location : GLint = -1
	
	/// In case of an array this property stores the locations of each
	/// element
	public var locations : [GLuint] = []
	
	
	/** 
	Initializes the attribute info with name and the target type
	
	:param: name The variable name of the attribute
	:param: target The vertex attribute type
	*/
	public init(name: String, target: GLAttribAlias) {
		self.name = name
		self.target = target
	}
}