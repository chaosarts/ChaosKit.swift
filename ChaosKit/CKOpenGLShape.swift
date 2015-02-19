//
//  CKOpenGLShape.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL
//
//public protocol CKOpenGLShape {
//	var data : [GLfloat]
//}

public class CKOpenGLShape {
	
	/** Provides the translation matrix */
	private final var _translation : mat4 = mat4.identity
	
	/** Provides the translation matrix */
	private final var _rotation : mat4 = mat4.identity
	
	/** Contains a list of child shapes */
	private final var _children : [CKOpenGLShape] = []
	
	/** Contains the internal parent shape */
	private final var _parent : CKOpenGLShape?
	
	/** Provides a list of buffers */
	public final var arraybuffer : CKOpenGLArrayBuffer?
	
	/** Contains the base program */
	public final var programs : [CKOpenGLProgram] = []
	
	/** Contains the model view matrix */
	public final var modelViewMatrix : mat4 {
		get {return _translation * _rotation}
	}
	
	/** */
	public final var children : [CKOpenGLShape] {
		get {return _children}
	}
	
	/** Contains the parent of the shape */
	public final var parent : CKOpenGLShape? {
		get {return _parent}
	}
	
	
	public init () {}
	
	
	/** 
	Adds a child to the shape
	*/
	public func addChild (child: CKOpenGLShape) -> Int {
		assert(child._parent != nil, "Child already has a parent object. Remove it first from its parent shape.")
		_children.append(child)
		return _children.count
	}

	
	/**
	Removes a child from shape
	*/
	public func removeChild (child: CKOpenGLShape) -> Int {
		var index : Int? = find(_children, child)
		if nil == index {return -1}
		removeChild(at: index!)
		return index!
	}
	
	
	/**
	*/
	public func removeChild (at index: Int) -> CKOpenGLShape? {
		if !isValidIndex(index) {return nil}
		
		var child : CKOpenGLShape = _children[index]
		child._parent = nil
		
		_children.removeAtIndex(index)
		
		return child
	}
	
	
	private func isValidIndex (index: Int) -> Bool {
		return index > 0 && index < _children.count
	}
}

extension CKOpenGLShape : Equatable {}

public func ==(l: CKOpenGLShape, r: CKOpenGLShape) -> Bool {
	return l === r
}
