//
//  CKOpenGLAttribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/*
|--------------------------------------------------------------------------
| Attribute Type Struct
|--------------------------------------------------------------------------
*/

/**
Enumerates the symbolic types of attributes of an vertex. This
is important since it is unkown how vertex attributes are named
within a shader source. This enumeration is widely used to easily 
determine which attribute one wants to refer to without knowing 
details of the shader source.
*/
public enum CKOpenGLAttributeType {
	/** Refers to the position of a vertex */
	case Position
	
	/** Refers to the color of a vertex */
	case Color
	
	/** Refers to the normal of a vertex */
	case Normal
	
	/** Refers to the texcoord of a vertex */
	case TexCoord
}


/*
|--------------------------------------------------------------------------
| Attribute Info Struct
|--------------------------------------------------------------------------
*/

/**
This struct represents a attribute variable in a vertex shader and consists
information about it, like the name, datatype, location(s)
*/
public struct CKOpenGLAttributeInfo {
	
	/** Provides the name of the attribute variable in the vertex 
	shader of a shader program */
	public let name : String
	
	/** Provides the attribute type/categorie in an program object*/
	public let target : CKOpenGLAttributeType
	
	/** Contains the data type the targeted attribute expects 
	(GL_FLOAT, GL_DOUBLE, etc)*/
	public var type : GLenum?
	
	/** Provides the size of the variable. If the attribute variable is
	an array, this property contains the count of elements. */
	public var size : GLint?
	
	/** Contains the attribute location fetched by glGetAttribLocation() */
	public var location : GLint = -1
	
	/** In case of an array this property stores the locations of each
	element */
	public var locations : [GLuint] = []
	
	
	/** 
	Initializes the attribute info with name and the target type
	
	:param: name The variable name of the attribute
	:param: target The vertex attribute type
	*/
	public init(name: String, target: CKOpenGLAttributeType) {
		self.name = name
		self.target = target
	}
}


/*
|--------------------------------------------------------------------------
| Attribute
|--------------------------------------------------------------------------
*/


/** 
The CKOpenGLAttributeData struct provides the data of a vertex attribute
*/
public struct CKOpenGLAttributeData<D: VectorType> : CKOpenGLBufferable {
	
	/** Provides the data as array of vectors. One vector serves one vertex. */
	private var _data : [D] = [D]()
	
	/** Contains the block size for interleaving */
	public var size : Int {get {return D.elementCount}}
	
	/** Provides the count of vertices it serves */
	public var count : Int {get {return _data.count}}
	
	/** Provides the attribute data as array of floats */
	public var array : [GLfloat] {
		get {
			var output : [GLfloat] = []
			for i in 0..<count {
				output = output + _data[i].array
			}
			return output
		}
	}
	
	/** Subscript access to the attribute data */
	public subscript (index: Int) -> [GLfloat] {
		get {return valid(index) ? _data[index].array : [GLfloat](count: D.elementCount, repeatedValue: 0.0)}
	}
	
	
	/** Initializes the structure */
	public init () {}
	
	
	/** Appends new data to the attribute */
	public mutating func append (element: D) {
		_data.append(element)
	}
	
	
	private func valid (index: Int) -> Bool {
		return index > 0 && index < _data.count
	}
}

