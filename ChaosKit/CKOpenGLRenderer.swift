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
	private var _projectionMatrix : mat4 = mat4.identity
	
	/** Contains the rotation matrix */
	private var _rotationMatrix : mat4 = mat4.identity
	
	/** Contains the rotation matrix */
	private var _translationMatrix : mat4 = mat4.identity
	
	/** Provides the model for the camera model */
	public var cameraModel : CKOpenGLCamera?
	
	/** Contains the scene to display by the renderer */
	public var scene : CKOpenGLSceneView? {
		didSet {if self != scene!.renderer {scene!.renderer = self; display()}}
	}
	
	/** Provides the projection matrix */
	public var projectionMatrix : mat4 {
		get {return _projectionMatrix}
	}
	
	/** Provides the model view matrix */
	public var modelMatrix : mat4 {
		get {return _translationMatrix * _rotationMatrix}
	}
	
	/** 
	NSView native draw action
	*/
    override public func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
		if cameraModel?.aspect != GLfloat(frame.width) / GLfloat(frame.height) {
			setViewport(0, y: 0, width: GLfloat(frame.width), height: GLfloat(frame.height))
		}
    }
	
	
	/** 
	Renders the scene
	*/
	public func render () {
		openGLContext.makeCurrentContext()
		scene?.display()
		glFlush()
	}
	
	
	/** 
	Sets the projection to perspective view according to passed parameters
	
	:params: fovy The angle in y direction of the frustum
	:params: aspect The width height aspect of the screen
	:params: near The near value of the frustum
	:params: far The far value of the frustum
	*/
	public func setPerspective(fovy f: GLfloat, aspect a: GLfloat, near n: GLfloat, far fa: GLfloat) -> CKOpenGLRenderer {
		_projectionMatrix = mat4.makePerspective(fovy: f, aspect: a, near: n, far: fa)
		return self
	}
	
	
	/**
	Sets the projection to perspective view according to passed parameters
	
	:param: left The left boundary of the view box
	:param: right The right boundary of the view box
	:param: bottom The bottom boundary of the view box
	:param: top The top boundary of the view box
	:param: near The near boundary of the view box
	:param: far The far boundary of the view box
	*/
	public func setFrustum (left l: GLfloat, right r: GLfloat, bottom b: GLfloat, top t: GLfloat, near n: GLfloat, far f: GLfloat) -> CKOpenGLRenderer {
		_projectionMatrix = mat4.makeFrustum(left: l, right: r, bottom: b, top: t, near: n, far: f)
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
	public func setOrthographic (left l: GLfloat, right r: GLfloat, bottom b: GLfloat, top t: GLfloat, near n: GLfloat, far f: GLfloat) -> CKOpenGLRenderer {
		_projectionMatrix = mat4.makeOrtho(left: l, right: r, bottom: b, top: t, near: n, far: f)
		return self
	}
	
	
	/**
	Sets the transation of the camera
	
	:param: x The translation in x direction
	:param: y The translation in y direction
	:param: z The translation in z direction
 	*/
	public func setTranslation (x mx: GLfloat, y my: GLfloat, z mz: GLfloat) {
		setTranslation([mx, my, mz])
	}
	
	
	/**
	Sets the translation of the camera
	
	:param: vec The direction, to translate to
	*/
	public func setTranslation (vec: vec3) {
		_translationMatrix = mat4.makeTranslate(vec)
	}
	
	
	/** 
	Sets the rotation of the camera
	
	:param: x The angle to rotate around the x axis
	:param: y The angle to rotate around the y axis
	:param: z The angle to rotate around the z axis
	*/
	public func setRotation (x rx: GLfloat, y ry: GLfloat, z rz: GLfloat) {
		_rotationMatrix = mat4.identity
		_rotationMatrix.rotateX(alpha: rx)
		_rotationMatrix.rotateY(alpha: ry)
		_rotationMatrix.rotateZ(alpha: rz)
	}
	
	
	/**
	Sets the rotation of the camera
	
	:param: vec A vector containing the angles to rotate around the according axis
	*/
	public func setRotation (vec: vec3) {
		setRotation(x: vec.x, y: vec.y, z: vec.z)
	}
	
	
	/**
	Sets the OpenGL viewport
	
	:param: x The x origin of the viewport
	:param: y The y origin of the viewport
	:param: width The width of the viewport
	:param: height The height of the viewport
	*/
	public func setViewport (x: GLint, y: GLint, width: GLfloat, height: GLfloat) {
		glViewport(x, y, GLint(width), GLint(height))
		
		if cameraModel == nil {
			render()
			return
		}
		
		var model : CKOpenGLCamera = cameraModel!
		var aspect : GLfloat = GLfloat(width) / GLfloat(height)
		
		if aspect == model.aspect {
			updateProjection(
				left: model.left, right: model.right,
				bottom: model.bottom, top: model.top,
				near: model.near, far: model.far
			)
			render()
			return
		}
		
		var left : GLfloat
		var right: GLfloat
		var bottom : GLfloat
		var top : GLfloat
		
		if aspect > model.aspect {
			var halfWidth : GLfloat = model.height * aspect / 2
			
			left = model.center.x - halfWidth
			right = model.center.x + halfWidth
			
			bottom = model.bottom
			top = model.top
		}
		else {
			var halfHeight : GLfloat = model.width / aspect / 2
			
			left = model.left
			right = model.right
			
			bottom = model.center.y - halfHeight
			top = model.center.y + halfHeight
		}
		
		updateProjection(left: left, right: right, bottom: bottom, top: top, near: model.near, far: model.far)
		render()
	}
	
	
	/** 
	Updates the projection matrix if a camera model is given
	
	:param: left The left boundary of the view box
	:param: right The right boundary of the view box
	:param: bottom The bottom boundary of the view box
	:param: top The top boundary of the view box
	:param: near The near boundary of the view box
	:param: far The far boundary of the view box
	*/
	private func updateProjection (left l: GLfloat, right r: GLfloat, bottom b: GLfloat, top t: GLfloat, near n: GLfloat, far f: GLfloat) {
		
		if nil == cameraModel {return}
		
		var model = cameraModel!
		
		if model.type == CKOpenGLCameraType.Orthographic {
			setOrthographic(left: l, right: r, bottom: b, top: t, near: n, far: f)
		}
		else {
			setFrustum(left: l, right: r, bottom: b, top: t, near: n, far: f)
		}
	}
}
