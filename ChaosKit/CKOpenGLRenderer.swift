//
//  CKOpenGLRenderer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 29.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL
import GLKit

public class CKOpenGLRenderer: NSOpenGLView {
	
	/** Contains the projection matrix */
	private var _projection : mat4 = mat4.identity
	
	/** Contains the translation matrix */
	private var _translation : mat4 = mat4.identity
	
	/** Contains the rotation matrix */
	private var _rotation : mat4 = mat4.identity
	
	/** Contains the scene to display by the renderer */
	public var scene : CKOpenGLSceneView? {
		didSet {if self != scene!.renderer {scene!.renderer = self}}
	}
	
	/** Provides the projection matrix */
	public var projectionMatrix : mat4 {
		get {return _projection}
	}
	
	/** Provides the model view matrix */
	public var modelViewMatrix : mat4 {
		get {return _translation * _rotation}
	}
	
	
    override public func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
		
		openGLContext.makeCurrentContext()
		scene?.display()
		glFlush()
    }
	
	
	public func render () {
		display()
	}
	
	
	/** 
	Sets the projection to perspective view according to passed parameters
	
	:params: fovy The angle in y direction of the frustum
	:params: aspect The width height aspect of the screen
	:params: near The near value of the frustum
	:params: far The far value of the frustum
	*/
	public func setPerspective(fovy f: CGFloat, aspect a: CGFloat, near n: CGFloat, far fa: CGFloat) -> CKOpenGLRenderer {
		_projection = mat4.makePerspective(fovy: f, aspect: a, near: n, far: fa)
		return self
	}
	
	
	/**
	Sets the projection to othographic view according to passed parameters
	
	:param: left The left boundary of the view box
	:param: right The right boundary of the view box
	:param: bottom The bottom boundary of the view box
	:param: top The top boundary of the view box
	:param: near The near boundary of the view box
	:param: far The far boundary of the view box
	*/
	public func setOrthographic (left l: CGFloat, right r: CGFloat, bottom b: CGFloat, top t: CGFloat, near n: CGFloat, far f: CGFloat) -> CKOpenGLRenderer {
		_projection = mat4.makeOrtho(left: l, right: r, bottom: b, top: t, near: n, far: f)
		return self
	}
	
	
	/**
	Sets the rotation of the screen
	
	:param: vec The vector containing the rotation around x, y and z axis
	*/
	public func setRotation (vec v: vec3) {
		_rotation = mat4.identity
		_rotation.rotateX(alpha: v.x)
		_rotation.rotateY(alpha: v.y)
		_rotation.rotateZ(alpha: v.z)
	}
	
	
	/**
	Sets the translation
	
	:param: vec The translation vector
	*/
	public func setTranslation (vec v: vec3) {
		_translation = mat4.makeTranslate(v)
	}
}
