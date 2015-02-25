//
//  CKOpenGLScene.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLScene {
	
	/** Provides the translation matrix */
	private final var _translation : mat4 = mat4.identity
	
	/** Provides the translation matrix */
	private final var _rotation : mat4 = mat4.identity
	
	/** Contains a list of objects in the scene */
	private final var _objects : [CKOpenGLShape] = []
	
	/** Contains a list of objects in the scene */
	public final var objects : [CKOpenGLShape] {get {return _objects}}
	
	/** Contains the model view matrix */
	public final var modelViewMatrix : mat4 {
		get {return _translation * _rotation}
	}
	
	public init () {}
	
	
	public func addObject (object: CKOpenGLShape) {
		
	}
	
	
	public func captureNotification (notification: NSNotification) {
		
	}
	
	
	public func bubbleNotification (notification: NSNotification) {
		
	}
}
