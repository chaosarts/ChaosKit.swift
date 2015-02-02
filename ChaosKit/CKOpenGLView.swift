//
//  CKOpenGLView.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 29.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLView : NSResponder  {
	
	/** Contains the translation matrix */
	private var _translation : mat4 = mat4.identity
	
	/** Contains the rotation matrix */
	private var _rotation : mat4 = mat4.identity
	
	/** Contains a list of subviews */
	final internal var subviews : [CKOpenGLView] = []
	
	/** Provides a list of buffers */
	public var buffers : UnsafeMutablePointer<GLuint>?
	
	/** Contains the renderer */
	public var renderer : CKOpenGLRenderer?
	
	/** Contains the base program */
	public var baseProgram : CKOpenGLProgram?
	
	/** Contains the modelViewMatrix */
	public var modelViewMatrix : mat4 {
		get {
			if nil == superview {_translation * _rotation}
			return superview!.modelViewMatrix * _translation * _rotation
		}
	}
	
	/** Provides the parant view of this view */
	public var superview : CKOpenGLView?
	
	
	/** 
	Initializes the view 
	*/
	public override init() {
		super.init()
	}

	required public init?(coder: NSCoder) {
	    super.init(coder: coder)
	}
	
	
	/** 
	This method is called by display and draws the view itself
	*/
	public func draw () {
		fatalError("Subclass needs own implementation. Do not call draw on base class.")
	}
	
	/** 
	This is where to call clear buffer functions
	*/
	public func clear () {
		fatalError("Subclass needs own implementation. Do not call clear on base class.")
	}
	
	
	/** 
	This method is called by the superview or the renderer to draw the view itself
	and afterwards its subviews
	*/
	final internal func display () {
		clear()
		draw()
		for subview in subviews {
			subview.display()
		}
	}
	
	
	/** 
	Renders the complete scene
	*/
	final public func render () {
		renderer?.render()
	}
	
	
	public func add(subview child: CKOpenGLView) {
		child.superview?.remove(subview: child)
		child.superview = self
		child.renderer = self.renderer
		self.subviews.append(child)
	}
	
	
	public func remove(subview child: CKOpenGLView) {
		var index : Int? = find(subviews, child)
		
		if nil == index {
			return
		}
		
		child.superview = nil
		child.renderer = nil
		subviews.removeAtIndex(index!)
	}
}


extension CKOpenGLView : Equatable {}

public func ==(l: CKOpenGLView, r: CKOpenGLView) -> Bool {
	return l === r
}
