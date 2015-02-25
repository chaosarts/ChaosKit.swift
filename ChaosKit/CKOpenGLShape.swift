//
//  CKOpenGLShape.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL


public protocol CKOpenGLShapeGenerator {
	
	class var count : Int {get}
	
	class func generate () -> [CKOpenGLAttributeType : CKOpenGLBufferable]
}


public class CKOpenGLShape {
	
	/** Provides the translation matrix */
	private final var _translation : mat4 = mat4.identity
	
	/** Provides the translation matrix */
	private final var _rotation : mat4 = mat4.identity
	
	/** Contains a list of child shapes */
	private final var _children : [CKOpenGLShape] = []
	
	/** Contains the internal parent shape */
	private final var _parent : CKOpenGLShape?
	
	/** Contains the draw mode, like GL_TRIANGLES etc */
	private final var _mode : GLenum = GLenum(GL_TRIANGLES)
	
	private final var _buffer : CKOpenGLBuffer = CKOpenGLBuffer()
	
	/** Contains the model view matrix */
	public final var modelViewMatrix : mat4 {
		get {return _translation * _rotation}
	}
	
	/** Contains the child shapes */
	public final var children : [CKOpenGLShape] {
		get {return _children}
	}
	
	/** Contains the parent of the shape */
	public final var parent : CKOpenGLShape? {
		get {return _parent}
	}
	
	/** Contains the draw mode */
	public final var mode : Int32 {
		get {return Int32(_mode)}
		set {_mode = GLenum(newValue)}
	}
	
	
	/** Initializes the shape with buffer data */
	public init () {}
	
	
	/** 
	Determines if the passed attribute type is provided by the shape or not
	
	:param: type The type to check
	:returns: True, when shape provides the attribute type. False otherwise
	*/
	public func matchRequirements (program: CKOpenGLProgram) -> Bool {
		for requirement in program.attributeRequirements {
			
		}
		
		return true
	}
	
	
	public func draw (program: CKOpenGLProgram) {
//		glClearColor(0, 0, 0, 1)
//		glClear(GLenum(GL_COLOR_BUFFER_BIT))
//		let pname : GLenum = GLenum(GL_VERTEX_ATTRIB_ARRAY_POINTER)
//		let modelViewMatrixSize : GLsizei = GLsizei(modelViewMatrix.array.count * sizeof(GLfloat))
//		let modelViewMatrixPointer : UnsafePointer<GLfloat> = toUnsafePointer(modelViewMatrix.array)
//		
//		let projectionMatrixSize : GLsizei = GLsizei(renderer.projectionMatrix.array.count * sizeof(GLfloat))
//		let projectionMatrixPointer : UnsafePointer<GLfloat> = toUnsafePointer(renderer.projectionMatrix.array)
//		
//		let transpose : GLboolean = GLboolean(GL_FALSE)
//		
//		for program in programs {
//			program.use()
//			
//			var uniformModelViewMatrix : CKOpenGLUniformInfo? = program.getUniformInfo(forType: .ModelViewMatrix)
//			
//			if uniformModelViewMatrix != nil && uniformModelViewMatrix!.location > 0 {
//				glUniformMatrix4fv(uniformModelViewMatrix!.location, modelViewMatrixSize, transpose, modelViewMatrixPointer)
//			}
//			
//			var uniformProjectionMatrix : CKOpenGLUniformInfo? = program.getUniformInfo(forType: .ProjectionViewMatrix)
//			
//			if uniformProjectionMatrix != nil && uniformProjectionMatrix!.location > 0 {
//				glUniformMatrix4fv(uniformProjectionMatrix!.location, projectionMatrixSize, transpose, projectionMatrixPointer)
//			}
//			
//			
//			for data in bufferdata {
//				
//				glBindBuffer(targetbuffer, data.vbo.memory)
//				
//				for type in data.scheme {
//					var attribInfo = program.getAttributeInfo(forType: type)
//					if nil == attribInfo || attribInfo!.location < 0 {continue}
//					
//					var location : GLuint = GLuint(attribInfo!.location)
//					var pointer : UnsafeMutablePointer<UnsafeMutablePointer<Void>> =
//					UnsafeMutablePointer<UnsafeMutablePointer<Void>>.alloc(1)
//					
//					let attribute : CKOpenGLBufferable = data.attribute[type]!
//					
//					glGetVertexAttribPointerv(location, pname, pointer)
//					
//					glVertexAttribPointer(location, attribute.size, GLenum(GL_FLOAT), attribute.normalize, data.stride, pointer.advancedBy(data.byteOffset(forType: type)))
//					
//					glEnableVertexAttribArray(location)
//				}
//			}
//			
//			
//			glDrawArrays(_mode, 0, 0)
//		}
	}
	
	
	/** 
	Adds a child to the shape
	*/
	public func addChild (child: CKOpenGLShape) -> Int {
		// Child must not have already a parent
		// or be the shape itself or be an ancestor
		if child.parent != nil || child === self || child.isAncestorOf(self) {return -1}
		_children.append(child)
		child._parent = self
		return _children.count
	}

	
	/**
	Removes a child from shape
	
	:param: child The child to remove
	:returns: The index of the child that has been removed
	*/
	public func removeChild (child: CKOpenGLShape) -> Int {
		var index : Int? = find(_children, child)
		if nil == index {return -1}
		removeChild(at: index!)
		return index!
	}
	
	
	/**
	Removes a child shape from this shape by index
	
	:param: index The index of the child to remove
	:returns: The shape, that has been removed
	*/
	public func removeChild (at index: Int) -> CKOpenGLShape? {
		if !isValidIndex(index) {return nil}
		
		var child : CKOpenGLShape = _children[index]
		child._parent = nil
		
		_children.removeAtIndex(index)
		
		return child
	}
	
	
	private func setParent (parent: CKOpenGLShape) {
		
	}
	
	
	private func isAncestorOf (shape: CKOpenGLShape) -> Bool {
		var ancestor : CKOpenGLShape? = shape.parent
		while ancestor != nil {
			if ancestor == self {return true}
			ancestor = ancestor!.parent
		}
		
		return false
	}
	
	
	private func isValidIndex (index: Int) -> Bool {
		return index > 0 && index < _children.count
	}
}

extension CKOpenGLShape : Equatable {}

public func ==(l: CKOpenGLShape, r: CKOpenGLShape) -> Bool {
	return l === r
}