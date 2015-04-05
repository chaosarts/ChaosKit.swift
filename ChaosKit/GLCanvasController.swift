//
//  GLCanvasController.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 26.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class GLCanvasController: NSObject, GLCanvasObserver, GLCameraObserver {
	
	
	unowned public var canvas : GLCanvas
	
	public var camera : GLCamera? {didSet {camera!.addObserver(self)}}
	
	public init (canvas c: GLCanvas) {
		canvas = c
		camera = GLCamera()
		
		super.init()
		
		canvas.add(obeserver: self)
	}
	
	
	private func updateView () {
		updateViewProjection()
	}
	
	
	private func updateViewProjection () {
		if self.camera == nil {return}
		var camera : GLCamera = self.camera!
		
		if camera.type == GLCameraType.Orthographic {
			canvas.setOrthographic(left: camera.left, right: camera.right, bottom: camera.bottom, top: camera.top, near: camera.near, far: camera.far)
		}
		else {
			canvas.setFrustum(left: camera.left, right: camera.right, bottom: camera.bottom, top: camera.top, near: camera.near, far: camera.far)
		}
	}
	
	
	public func resizeCameraViewport (rect: NSRect) {
		if self.camera == nil {return}
		
		var camera :GLCamera = self.camera!
		
		glViewport(0, 0, GLint(rect.width), GLint(rect.height))
		
		var aspect : GLfloat = GLfloat(rect.width) / GLfloat(rect.height)
		
		var left : GLfloat
		var right: GLfloat
		var bottom : GLfloat
		var top : GLfloat
		
		if aspect > camera.aspect {
			var halfWidth : GLfloat = camera.height * aspect / 2
			
			left = camera.center.x - halfWidth
			right = camera.center.x + halfWidth
			
			bottom = camera.bottom
			top = camera.top
		}
		else {
			var halfHeight : GLfloat = camera.width / aspect / 2
			
			left = camera.left
			right = camera.right
			
			bottom = camera.center.y - halfHeight
			top = camera.center.y + halfHeight
		}
		
		camera.setViewport(left: left, right: right, bottom: bottom, top: top, near: camera.near, far: camera.far)
	}
	
	
	public func moveCamera (x mx: GLfloat, y my: GLfloat, z mz: GLfloat) {
		camera!.position = [mx, my, mz]
	}
	
	
	public func rotateCamera (x rx: GLfloat, y ry: GLfloat, z rz: GLfloat) {
		camera!.rotation = [rx, ry, rz]
	}
	
	
	public func canvasDidResize(notification: NSNotification) {
		resizeCameraViewport(canvas.frame)
	}
	
	
	public func viewportDidChange(notification: NSNotification) {
		updateViewProjection()
	}
	
	
	public func modelDidMove(notification: NSNotification) {
		
	}
}
