//
//  GLShape.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL

/**
The base class for a 3d object in OpenGL. A shape is described by different 
types of attributes (Position, Color, Normals) as lists of vectors contained 
in corresponding GLVertexAttribute objects.
*/
public class GLShape : GLDisplayObject {
	
	// STORED VALUES
	// *************
	
	/// Provides a attribute-alias-attribute-map
	private var _attributes : [GLAttribAlias : GLVertexAttribute] = [GLAttribAlias : GLVertexAttribute]()
	
	/// indexWrapper functions for the attributes values in case
	/// their values count won't match the position count
	private var _indexWrappers : [GLAttribAlias : CKIndexWrapper] = [GLAttribAlias : CKIndexWrapper]()
	
	/// Provides the color to use for next vertex, if provided
	private var _color : vec4?
	
	/// Provides the normal to use for next vertex, if provided
	private var _normal : vec3?

	/// The draw mode of the shape
	public var mode : GLenum = GLenum(GL_TRIANGLES)
	
	
	// DERIVED VALUES
	// **************
	
	/// Provides the color to use for next vertex
	public var color : vec4? {
		get {return _color}
		set {if !canSetForAlias(.Color) || newValue == nil {return}}
	}
	
	/// Provides the normal to use for next vertex, if provided
	public var normal : vec3? {
		get {return _normal}
		set {if !canSetForAlias(.Normal) && newValue != nil {_normal = newValue}}
	}
	
	// SUBSCRIPTS 
	// **********

	/** Initialzes the Shape */
	public override init () {
		super.init()
		_attributes[.Position] = GLVertexAttributeArray<vec3>()
		
		_attributes[.Color] = GLVertexAttributeArray<vec4>()
		_indexWrappers[.Color] = repeatIndex
		
		_attributes[.Normal] = GLVertexAttributeArray<vec3>()
		_indexWrappers[.Normal] = repeatIndex
	}
	
	
	public func createVertex (position: vec3) {
		_attributes[.Position]!.append(position.array)
		
		if canSetForAlias(.Color) && _color != nil {
			_attributes[.Color]!.append(_color!.array)
		}
		
		if canSetForAlias(.Normal) && _normal != nil {
			_attributes[.Normal]!.append(_normal!.array)
		}
	}
	
	
	public func getColor (index: Int) -> [GLfloat] {
		var attribute : GLVertexAttribute = _attributes[.Color]!
		if attribute.count == 0 {return []}

		var wrapper : CKIndexWrapper = _indexWrappers[.Color]!
		var newindex : Int = wrapper(index: index, min: 0, max: attribute.count - 1)
		
		return attribute[newindex]
	}
	
	
	public func getNormal (index: Int) -> [GLfloat] {
		var attribute : GLVertexAttribute = _attributes[.Normal]!
		if attribute.count == 0 {return []}
		
		var wrapper : CKIndexWrapper = _indexWrappers[.Normal]!
		var newindex : Int = wrapper(index: index, min: 0, max: attribute.count - 1)
		
		return attribute[newindex]
	}
	
	
	private func canSetForAlias (alias: GLAttribAlias) -> Bool {
		return _attributes[alias] != nil && _attributes[alias]!.count == _attributes[.Position]!.count
	}
}


public protocol GLShaper {
	func form () -> GLShape
}