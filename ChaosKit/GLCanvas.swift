//
//  GLCanvas.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 29.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL
import GLKit


public class GLCanvas: NSOpenGLView, GLTransformable {
	
	/** Contains the projection matrix */
	private var _projectionViewMatrix : mat4 = mat4.identity
	
	/** Contains the rotation matrix */
	private var _modelViewMatrix : mat4 = mat4.identity
	
	/** Provides the scene to render */
	public var stage : GLStage?
	
	public var preRenderpasses : [GLOffscreenRenderpass] = []
	
	public var mainRenderpass : GLRenderpass?
	
	public var postRenderpasses : [GLOffscreenRenderpass] = []
	
	/** Provides the projection matrix */
	public var projectionViewMatrix : mat4 {
		get {return _projectionViewMatrix}
	}
	
	/** Provides the model view matrix */
	public var modelViewMatrix : mat4 {
		get {return _modelViewMatrix}
	}
	
	
	public func add (obeserver o: GLCanvasObserver) {
		var notificationCenter : NSNotificationCenter = NSNotificationCenter.defaultCenter();
		var selector : Selector = Selector("canvasDidResize:")
		
		if o.respondsToSelector(selector) {
			notificationCenter.addObserver(o, selector: selector, name: GLCanvasEvent.Resize.rawValue, object: self)
		}
	}
	
	
	/** 
	NSView native draw action
	*/
    override public func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
		var notificationCenter : NSNotificationCenter = NSNotificationCenter.defaultCenter();
		var notification : NSNotification = NSNotification(name: GLCanvasEvent.Resize.rawValue, object: self)
		
		notificationCenter.postNotification(notification)
    }
	
	
	public func drawStage () {
		if stage == nil || mainRenderpass == nil {return}
		
		for pass in preRenderpasses {
			pass.render(projectionViewMatrix, modelViewMatrix, stage!)
		}
		
		mainRenderpass!.render(projectionViewMatrix, modelViewMatrix, stage!)
	}
	
	
	public func bufferShapeData (shape: GLShape) -> UnsafeMutablePointer<GLuint> {
		var data : [GLfloat] = packShapeData(shape)
		var size : GLsizeiptr = GLsizeiptr(shape.vertice.count * 12 * sizeof(GLfloat))
		var buffers : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenBuffers(1, buffers)
		glBindBuffer(GLenum(GL_ARRAY_BUFFER), buffers.memory)
		glBufferData(GLenum(GL_ARRAY_BUFFER), size, UnsafePointer<Void>(toUnsafePointer(data)), GLenum(GL_STATIC_DRAW))
		glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
		return buffers
	}
	
	
	public func packShapeData (shape: GLShape) -> [GLfloat]{
		var data : [GLfloat] = []
		for vertex in shape.vertice {
			data.extend(vertex.position.array)
			data.extend(vertex.color.array)
			data.extend(vertex.normal.array)
			data.extend(vertex.texcoord.array)
		}
		
		return data
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
	public func setFrustum (left l: GLfloat, right r: GLfloat, bottom b: GLfloat, top t: GLfloat, near n: GLfloat, far f: GLfloat) -> GLCanvas {
		_projectionViewMatrix = mat4.makeFrustum(left: l, right: r, bottom: b, top: t, near: n, far: f)
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
	public func setOrthographic (left l: GLfloat, right r: GLfloat, bottom b: GLfloat, top t: GLfloat, near n: GLfloat, far f: GLfloat) -> GLCanvas {
		_projectionViewMatrix = mat4.makeOrtho(left: l, right: r, bottom: b, top: t, near: n, far: f)
		return self
	}
	
	
	/**
	Sets the translation of the camera
	
	:param: vec The direction, to translate to
	*/
	public func translate (vec v: vec3) {
		_modelViewMatrix.translate(v)
	}
	
	
	public func translate (x tx: GLfloat, y ty: GLfloat, z tz: GLfloat) {
		translate(vec: [tx, ty, tz])
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
	
	
	public func resetTransformation () {
		_modelViewMatrix = mat4.identity
	}
}



public enum GLCanvasEvent : String {
	case Resize = "GLCanvasEvent.Resize"
}

@objc
public protocol GLCanvasObserver : NSObjectProtocol {
	optional func canvasDidResize (notification: NSNotification)
}