//
//  CKOpenGLVertex.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 03.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public enum CKOpenGLVertexAttributeType {
	case Position
	case Color
	case Normal
	case TexCoord
}


public struct CKOpenGLVertexAttribute<T where T: MatrixType> {
	/** Provides the data internally */
	private var _datas : [GLfloat] = []
	
	/** Readonly access to vertex data */
	public var datas : [GLfloat] {get {return _datas}}
	
	/** Provides the vector size */
	public let elementSize : UInt
	
	/** Provides the target atrtibute type (vertex position, vertex color, etc) */
	public let type : CKOpenGLVertexAttributeType
	
	/** 
	Initializes the value
	
	:param: type
	*/
	public init(type: CKOpenGLVertexAttributeType) {
		self.elementSize = T.elementCount
		self.type = type
	}
	
	/** 
	Adds new data to the vertex attribute
	
	:param: data The data to add
	*/
	mutating public func add (data d: T) {
		_datas = _datas + d.array
	}
}