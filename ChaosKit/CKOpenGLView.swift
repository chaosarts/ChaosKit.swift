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
	private var _translation : mat4?
	
	/** Contains the rotation matrix */
	private var _rotation : mat4?
	
	/** Provides a list of buffers */
	private final var _buffers : UnsafeMutablePointer<GLuint>?
	
	/** Contains the size of the buffer */
	private final var _bufferSize : Int = 0
	
	/** Contains a list of subviews */
	public final var subviews : [CKOpenGLView] = []
	
	/** Provides the parant view of this view */
	public final var superview : CKOpenGLView?
	
	/** Readonly buffer property*/
	public final var buffers : UnsafeMutablePointer<GLuint>? {
		get {return _buffers}
	}
	
	/** Contains the base program */
	public var programs : [CKOpenGLProgram] = []
	
	/** Contains the vertice of the view */
	public final var vertice : [CKVertex] = []
	
	/** Contains the renderer */
	public var renderer : CKOpenGLRenderer? {
		didSet {for subview in subviews {subview.renderer = renderer}}
	}
	
	/** Contains the modelViewMatrix */
	public final var modelViewMatrix : mat4 {
		get {
			var mat : mat4 = mat4.identity
			if nil != _translation {mat = _translation!}
			if nil != _rotation {mat = mat * _rotation!}
			if nil != superview {mat = superview!.modelViewMatrix}
			return mat
		}
	}
	
	/** 
	 Returns the projection matrix
	 */
	public final var projectionViewMatrix : mat4 {
		get {
			if nil == renderer {return mat4.identity}
			return renderer!.projectionMatrix
		}
	}
	
	
	/** 
	Initializes the view 
	*/
	public override init() {
		super.init()
	}
	
	
	/** 
	Initializes the view
	*/
	required public init?(coder: NSCoder) {
	    super.init(coder: coder)
	}
	
	
	/** 
	Allocates the according memory size
	
	:param: num
	*/
	public func allocateBufferMemory (num: Int) {
		if _buffers != nil && _bufferSize > 0 {
			_buffers!.destroy()
			_buffers!.dealloc(_bufferSize)
		}
		
		_buffers = UnsafeMutablePointer<GLuint>.alloc(num)
		_bufferSize = num
	}
	
	
	/** 
	This method is called by display and draws the view itself
	*/
	public func draw () {}
	
	
	/** 
	This is where to call clear buffer functions
	*/
	public func clear () {}
	
	
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
	
	
	/** 
	Adds a new subview to this view
	
	:param: subview The subview to add
	:returns: The view itself for chaining
	*/
	public func add(subview child: CKOpenGLView) -> CKOpenGLView {
		child.superview?.remove(subview: child)
		child.superview = self
		child.renderer = self.renderer
		self.subviews.append(child)
		
		return self
	}
	
	
	/** 
	Removes a subview from this view
	
	:param: subview The subview to remove
	:returns: The view itself for chaining
	*/
	public func remove(subview child: CKOpenGLView) -> CKOpenGLView {
		var index : Int? = find(subviews, child)
		
		if nil == index {return self}
		
		child.superview = nil
		child.renderer = nil
		subviews.removeAtIndex(index!)
		return self
	}
}


extension CKOpenGLView : Equatable {}

public func ==(l: CKOpenGLView, r: CKOpenGLView) -> Bool {
	return l === r
}
