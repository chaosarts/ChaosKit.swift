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
in corresponding GLAttribData objects.
*/
public class GLShape : GLDisplayObject {
	
	/*
	|--------------------------------------------------------------------------
	| Stored properties
	|--------------------------------------------------------------------------
	*/

	/// Provides the geometry
	public var geometry : GLShapeProperty
	
	/// Provides the surface
	public var surface : GLSurface = GLSurface()
	
	/*
	|--------------------------------------------------------------------------
	| Derived properties
	|--------------------------------------------------------------------------
	*/
	
	/// Provides the line width
	public var linewidth : GLfloat = 1
	
	/// Provides the point size
	public var pointsize : GLfloat = 1
	
	/// Provides the draw mode
	public var mode : GLenum = GLenum(GL_TRIANGLES)
	
	/// Provides the bufferables
	public var bufferables : [GLAttributeSelector : GLBufferable] {
		get {
			var output : [GLAttributeSelector : GLBufferable] = surface.bufferables
			var selector : GLAttributeSelector = GLAttributeSelector(type: .Position)
			output[selector] = geometry
			return output
		}
	}

	
	/*
	|--------------------------------------------------------------------------
	| Initializers
	|--------------------------------------------------------------------------
	*/
	
	/** 
	Initialzes the Shape 
	*/
	public init (geometry: GLShapeProperty) {
		self.geometry = geometry
	}
	
	
	/*
	|--------------------------------------------------------------------------
	| Methods
	|--------------------------------------------------------------------------
	*/
	
	public func compile () {
		
	}
}