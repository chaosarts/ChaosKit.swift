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

public struct GLAttribLocation {
	
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