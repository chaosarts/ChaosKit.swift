//
//  GLShape.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 17.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL


public class GLShape : GLDisplayObject {
	
	private var _vertice : [GLVertex] = []
	
	public var mode : GLenum = GLenum(GL_TRIANGLES)
	
	public var vertice : [GLVertex] {
		get {return _vertice}
	}
	
	public subscript (index: Int) -> GLVertex? {
		get {return _vertice[index]}
	}
	
	
	public func append (vertex: GLVertex) {
		_vertice.append(vertex)
	}
	
	
	public func extend (vertice: [GLVertex]) {
		_vertice.extend(vertice)
	}
}


public protocol GLShaper {
	func form () -> GLShape
}