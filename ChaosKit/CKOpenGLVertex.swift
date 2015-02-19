//
//  CKOpenGLVertex.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 03.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/**
Base protocols for attributed vertex types
*/
public protocol CKOpenGLAttributed {
	
	/** Derives the data array for buffering */
	var data : [GLfloat] {get}
	
	/** 
	Determines if the passed tpe is supported by the attributed struct or class
	
	:param: type The type to check
	:returns: True when attribute is supported, otherwise false
	*/
	func has (type: CKOpenGLAttributeType) -> Bool
	
	/**
	Returns the according vertex attribute if supported
	
	:param: type The vertex attribute type to get
	:returns: The according vertex attribute, if supported, otherwise nil
	*/
	func get (type: CKOpenGLAttributeType) -> VectorType?
}


/**
Protocol to inidcate, that a vertex struct/class is attributed with position data
*/
public protocol CKOpenGLPositionAttributed : CKOpenGLAttributed {
	/** Returns the position data */
	var position : vec3 {get set}
}


/**
Protocol to inidcate, that a vertex struct/class is attributed with position data
*/
public protocol CKOpenGLColorAttributed : CKOpenGLAttributed {
	var color : vec4 {get set}
}


/**
Protocol to inidcate, that a vertex struct/class is attributed with position data
*/
public protocol CKOpenGLNormalAttributed : CKOpenGLAttributed {
	var normal : vec3 {get set}
}

/**
Protocol to inidcate, that a vertex struct/class is attributed with position data
*/
public protocol CKOpenGLTexCoordAttributed : CKOpenGLAttributed {
	var texcoord : vec3 {get set}
}


/**
This is the base class for vertex types.
*/
public class CKOpenGLVertex : CKOpenGLPositionAttributed {
	
	/** Contains the attributes */
	private var _attributes : [CKOpenGLAttributeType : vec4] = [CKOpenGLAttributeType : vec4]()
	
	/** Provides the position data */
	public var position : vec3 {
		get {return vec3(v: _attributes[.Position]!)}
		set {_attributes[.Position] = vec4(v: newValue)}
	}
	
	/** Provides the vertex data as array */
	public var data : [GLfloat] {
		get {return position.array}
	}
	
	subscript (type: CKOpenGLAttributeType) -> VectorType? {
		get {return get(type)}
	}
	
	public init (position: vec3) {
		self.position = position
	}
	
	public func has(type: CKOpenGLAttributeType) -> Bool {
		return _attributes[type] != nil
	}
	
	public func get(type: CKOpenGLAttributeType) -> VectorType? {
		return _attributes[type]
	}
}


public class CKOpenGLNormaledVertex : CKOpenGLVertex, CKOpenGLNormalAttributed {
	public var normal : vec3 {
		get {return vec3(v: _attributes[.Normal]!)}
		set {_attributes[.Normal] = vec4(v: newValue)}
	}
	
	public override var data : [GLfloat] {
		get {return super.data + normal.array}
	}
	
	public init (position: vec3, normal: vec3) {
		super.init(position: position)
		self.normal = normal
	}
}


public class CKOpenGLColoredVertex : CKOpenGLNormaledVertex, CKOpenGLColorAttributed {
	public var color : vec4 {
		get {return _attributes[.Color]!}
		set {_attributes[.Position] = newValue}
	}
	
	public override var data : [GLfloat] {
		get {return super.data + color.array}
	}
	
	public init (position: vec3, normal: vec3, color: vec4) {
		super.init(position: position, normal: normal)
		self.color = color
	}
}


public class CKOpenGLTexturedVertex : CKOpenGLColoredVertex, CKOpenGLTexCoordAttributed {
	public var texcoord : vec3 {
		get {return vec3(v: _attributes[.TexCoord]!)}
		set {_attributes[.TexCoord] = vec4(v: newValue)}
	}
	
	public override var data : [GLfloat] {
		get {return super.data + texcoord.array}
	}
	
	public init (position: vec3, normal: vec3, color: vec4, texcoord: vec3) {
		super.init(position: position, normal: normal, color: color)
		self.texcoord = texcoord
	}
}