//
//  GLRenderbuffer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 04.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLRenderbuffer : GLBase {
	
	private var _ptr : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
	
	public var ptr : UnsafeMutablePointer<GLuint> {get {return _ptr}}
	
	public let target : GLenum
	
	public init (target t: Int32) {
		glGenRenderbuffers(1, _ptr)
		target = GLenum(t)
		super.init(id: _ptr.memory)
	}
	
	
	public func bind () {
		glBindRenderbuffer(target, id)
	}
	
	
	public func unbind () {
		glBindRenderbuffer(target, 0)
	}
}