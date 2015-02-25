//
//  CKOpenGLVertex.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 03.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

/**
Protocol for vertex
*/
public protocol CKOpenGLVertexGenerator {
	func generate () -> [CKOpenGLVertex]
}

/**
*/
public struct CKOpenGLVertexAttribute<D: VectorType> : CKOpenGLAttribute {
	
	/** Typealias to trace it's data source back */
	typealias BaseType = D
	
	typealias Element = GLfloat
	
	/** The vertex attribute data represented as GLfloat array */
	public let data : [GLfloat]
	
	/** Initializes the attribute */
	public init (data d: D) {
		data = d.array
	}
}

extension CKOpenGLVertexAttribute : ArrayLiteralConvertible {
	public init(arrayLiteral elements: GLfloat...) {
		var d = [GLfloat](count: D.elementCount, repeatedValue: 0.0)
		
		for i in 0..<D.elementCount {
			if elements.count < i {break}
			d[i] = elements[i]
		}
		
		data = d
	}
}


/**
This struct provides information for one vertex. It contains the vertex attribute values and their
implicit association with their shader variable.
*/
public struct CKOpenGLVertex {
	
	/** Contains a map of attributes */
	private var _attributes : [CKOpenGLAttributeType : CKOpenGLAttribute] = [CKOpenGLAttributeType : CKOpenGLAttribute]()
	
	/** Contains a list of types, where data is set for this vertex */
	public var types : [CKOpenGLAttributeType] {get {return _attributes.keys.array}}
	
	/** Array access to attributes */
	subscript (type: CKOpenGLAttributeType) -> CKOpenGLAttribute? {
		get {return _attributes[type]}
		set {_attributes[type] = newValue}
	}
	
	
	/** 
	Initializes the vertex 
	*/
	public init () {}
	
	
	/** 
	Sets the attribute for this vertex 
	*/
	public mutating func setAttribute (attribute: CKOpenGLAttribute, forType: CKOpenGLAttributeType) {
		_attributes[forType] = attribute
	}
}


