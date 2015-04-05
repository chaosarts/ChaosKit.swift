//
//  GLDisplayObject.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/**
Protocol for trasnlatable objects
*/
public protocol GLTranslatable {
	/**
	Translates the object in given x, y and z direction
	
	:param: x The translate value along the x axis
	:param: y The translate value along the y axis
	:param: z The translate value along the z axis
	*/
	func translate (x tx: GLfloat, y ty: GLfloat, z tz: GLfloat)
	
	/**
	Translates the object in given x, y and z direction
	
	:param: vec Vector that gives the direction to translate
	*/
	func translate (vec v: vec3)
}


/**
Protocol for rotateable objects
*/
public protocol GLRotatable {
	/**
	Rotates the display object around the x axis
	*/
	func rotateX (alpha a: GLfloat)
	
	
	/**
	Rotates the display object around the y axis
	*/
	func rotateY (alpha a: GLfloat)
	
	
	/**
	Rotates the display object around the z axis
	*/
	func rotateZ (alpha a: GLfloat)
	
	
	/**
	Rotates the display object around an arbitrary axis
	*/
	func rotate (alpha a: GLfloat, axis: vec3)
}


/**
Protocol for transformable objects
*/
public protocol GLTransformable : GLTranslatable, GLRotatable {
	func resetTransformation ()
}


/**
Protocol for displable objects
*/
public protocol GLDisplayable : GLTransformable {
	
	/// Contains the model view matrix
	var modelViewMatrix : mat4 {get}
	
	/// Contains the scene to which the displayable belongs to
	var stage : GLStage? {get set}
	
	/// Contains the parent container of the displayable
	var parent : GLContainer? {get set}
	
	/// Indicates if the displayable is visible or not
	var visible : Bool {get set}
	
	/// Draws the displayable
	func display ()
}


/**
Base class for displayable objects. Does not implement the GLDisplayable
protocol, since it is 'abstract' and therefore it is unknown what to do in 
display method.
*/
public class GLDisplayObject : NSObject, GLDisplayable {

	/// Provides the translation matrix
	private var _modelViewMatrix : mat4 = mat4.identity {
		didSet {_modelViewMatrixCacheClean = false}
	}
	
	private var _modelViewMatrixCache : mat4?
	
	private var _modelViewMatrixCacheClean : Bool = false
	
	/// Contains the scene to which the object belongs to
	public var stage : GLStage?
	
	/// Contains the parent element
	public var parent : GLContainer? {
		didSet {_modelViewMatrixCacheClean = false}
	}
	
	/// Indicates if the displayable is visible or not
	public var visible : Bool = true
	
	/// Contains the model view matrix
	public final var modelViewMatrix : mat4 {
		get {
			updateMatrixCache()
			return _modelViewMatrixCache!
		}
	}
	
	
	public override init () {}
	
	
	public func resetTransformation () {
		_modelViewMatrix = mat4.identity
	}
	
	
	public func display () {}
	
	
	/** 
	Translates the display object
	*/
	public func translate (x tx: GLfloat, y ty: GLfloat, z tz: GLfloat) {
		_modelViewMatrix.translate(x: tx, y: ty, z: tz)
	}
	
	
	/**
	Translates the display object
	*/
	public func translate (vec v: vec3) {
		translate(x: v.x, y: v.y, z: v.z)
	}
	
	
	/**
	Rotates the display object around the x axis
	*/
	public func rotateX (alpha a: GLfloat) {
		rotate(alpha: a, axis: [1 ,0 ,0])
	}
	
	
	/**
	Rotates the display object around the y axis
	*/
	public func rotateY (alpha a: GLfloat) {
		rotate(alpha: a, axis: [1 ,0 ,0])
	}
	
	
	/**
	Rotates the display object around the z axis
	*/
	public func rotateZ (alpha a: GLfloat) {
		rotate(alpha: a, axis: [1 ,0 ,0])
	}
	
	
	/**
	Rotates the display object around an arbitrary axis
	*/
	public func rotate (alpha a: GLfloat, axis: vec3) {
		_modelViewMatrix.rotate(alpha: a, vec: axis)
	}
	
	
	internal func updateMatrixCache () {
		if _modelViewMatrixCacheClean { return }
		if parent != nil {_modelViewMatrixCache = parent!.modelViewMatrix * _modelViewMatrix}
		else {_modelViewMatrixCache = _modelViewMatrix}
		_modelViewMatrixCacheClean = true
	}
}

extension GLDisplayObject : Equatable {}

public func ==(left: GLDisplayObject, right: GLDisplayObject) -> Bool {
	return left === right
}
