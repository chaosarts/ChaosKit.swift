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
	
	/** Provides a list of light sources */
	private var _lightSources : [CKOpenGLLight] = []
	
	
	public var lightSources : [CKOpenGLLight] {
		get {return _lightSources}
	}
	
	
	/** Provides the opengl renderer */
	override public var renderer : CKOpenGLRenderer? {
		didSet {
			if self != self.renderer!.scene {self.renderer!.scene = self}
			for subview in subviews {subview.renderer = self.renderer}
		}
	}
	
	public override func clear () {
		glClearColor(clearColor.r, clearColor.g, clearColor.b, clearColor.a);
		glClearDepth(1)
		glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
	}
	
	
	public func registerLightSource (light: CKOpenGLLight) {
		
	}
	
	
	public func setupLight (program: CKOpenGLProgram) {
		for l in lightSources {
			
		}
	}
}
