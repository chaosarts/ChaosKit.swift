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
the name of the variable. With the help of AttributeInfo objects  
this a Program object establishes the connection between a 
concrete variable in a shader program with this enumeration cases.

- Color: Stands for the color attribute variable
- Normal: Stands for the normal attribute variable
- Position: Stands for the position attribute variable
- TexCoord: Stands for the texture coordinate attribute variable
*/
public enum AttributeTarget {
	
	/// Stands for the color attribute variable
	case Color
	
	/// Stands for the normal attribute variable
	case Normal
	
	/// Stands for the position attribute variable
	case Position
	
	/// Stands for the texture coordinate attribute variable
	case TexCoord
	
	/// Contains all cases
	static let cases : [AttributeTarget] = [.Color, .Normal, .Position, .TexCoord]
}


/*
|--------------------------------------------------------------------------
| Attribute Info Struct
|--------------------------------------------------------------------------
*/

/**
This structs helps to bridge the gap between a concrete variable name in a
shader program and AttributeTarget case. Further more consists of
known OpenGL properties, such as the symbolic attribute location, size
and name.
*/
public struct AttributeInfo {
	
	/// Provides the name of the attribute variable in the vertex shader of
 	/// a shader program.
	public let name : String
	
	/// Provides the attribute type/categorie in an program object
	public let target : AttributeTarget
	
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
	public init(name: String, target: AttributeTarget) {
		self.name = name
		self.target = target
	}
}


/*
|--------------------------------------------------------------------------
| Attribute
|--------------------------------------------------------------------------
*/

public protocol AttributeDataType {
	
	/// Contains the batch size for interleaving
	var size : Int {get}
	
	/// Provides the count of vertices it serves
	var count : Int {get}
	
	/// Contains the data to buffer as array of float
	var array : [GLfloat] {get}
	
	/**
	Subscript access to a single data vector of the vertex  at passed
	index as array.
	
	:param: index The index of the attribute vector to access
	:returns: The attribute vector as array of GLfloat
	*/
	subscript (index: Int) -> [GLfloat] {get}
}

/** 
The AttributeData struct provides the data of a vertex attribute
*/
public struct AttributeData<D: VectorType> : AttributeDataType {
	
	/// Provides the data as array of vectors. One vector serves one vertex.
	private var _data : [D] = [D]()
	
	/// Contains the block size for interleaving
	public var size : Int {get {return D.elementCount}}
	
	/// Provides the count of vertices it serves
	public var count : Int {get {return _data.count}}
	
	/// Provides the attribute data as array of floats
	public var array : [GLfloat] {
		get {
			var output : [GLfloat] = []
			for i in 0..<count {output = output + _data[i].array}
			return output
		}
	}
	
	
	/**
	Subscript access to a single data vector of the vertex  at passed
	index as array.
	*/
	public subscript (index: Int) -> [GLfloat] {
		get {return valid(index) ? _data[index].array : [GLfloat](count: D.elementCount, repeatedValue: 0.0)}
	}
	
	
	/** 
	Initializes the structure
	
	:param: usage The usage for the buffer, like GL_STATIC_DRAW
	*/
	public init () {}
	
	
	/** 
	Appends new data to the attribute 
	*/
	public mutating func append (element: D) {
		_data.append(element)
	}
	
	
	/**
	Determines if the index is valid or not
	
	:param: index The index to check
	:returns: True if the index is given for _data, otherwise false
	*/
	private func valid (index: Int) -> Bool {
		return index > 0 && index < _data.count
	}
}

