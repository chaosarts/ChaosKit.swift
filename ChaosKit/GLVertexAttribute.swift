//
//  GLVertexAttribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 26.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


/// Protocol to descript a vertex attribute. A GLVertexAttribute 
/// object consists of the values for one vertex attribute.
public protocol GLVertexAttribute {
	
	/// This provides the size of one vertex attribute value
	var size : Int {get}
	
	/// Provides the count of vertices it serves
	var count : Int {get}
	
	/// Indicates how to store the values for OpenGL (GL_STATIC_DRAW, GL_DYNAMIC_DRAW)
	var dynamic : Bool {get}
	
	/** 
	Returns the attribute value for vertex at given index
	
	:param: index The index of the vertex to access
	*/
	subscript (index: Int) -> [GLfloat] {get set}
	
	mutating func append(data: [GLfloat])
}


public struct GLVertexAttributeArray<T: Vector> : GLVertexAttribute {
	
	/// Internal value storage
	public var values : [T] = []
	
	/// This provides the size of one vertex attribute value
	public var size : Int {get {return T.elementCount}}
	
	/// Provides the count of vertices it serves
	public var count : Int {get {return values.count}}
	
	/// Indicates how to store the values for OpenGL (GL_STATIC_DRAW, GL_DYNAMIC_DRAW)
	public var dynamic : Bool = false
	
	
	/**
	Returns the attribute value for vertex at given index
	
	:param: index The index of the vertex to access
	*/
	public subscript (index: Int) -> [GLfloat] {
		get {return values[index].array}
		set {values[index] = T(newValue)}
	}
	
	
	public mutating func append(data: [GLfloat]) {
		values.append(T(data))
	}
}