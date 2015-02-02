//
//  CKOpenGLScene.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 29.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLSceneView: CKOpenGLView {
	
	public var clearColor : RGBAColor = (0, 0, 0, 1)
	
	/** Contains the modelViewMatrix */
	override public var modelViewMatrix : mat4 {
		get {
			if nil == renderer {super.modelViewMatrix}
			return renderer!.modelViewMatrix * super.modelViewMatrix
		}
	}
	
	override public var renderer : CKOpenGLRenderer? {
		didSet {
			if self != self.renderer!.scene {self.renderer!.scene = self}
			for subview in subviews {subview.renderer = self.renderer}
		}
	}
	
	public override func draw() {}
	
	public override func clear () {
		glClearColor(clearColor.r, clearColor.g, clearColor.b, clearColor.a);
		glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
	}
}
