//
//  GLVertex.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct GLVertex {
	private var _attributes : [GLAttribAlias : GLVertexAttribute] = [GLAttribAlias : GLVertexAttribute]()
	
	public subscript (attribname: GLAttribAlias) -> GLVertexAttribute? {
		get {return _attributes[attribname]}
		set {_attributes[attribname] = newValue}
	}
}


public protocol GLVertexAttribute {
	var array : [GLfloat] {get}
}


public struct GLVertexAttributeData<T: VectorType> : GLVertexAttribute {

	typealias Type = T

	public let array : [GLfloat]
	
	public init (_ vector: T) {
		array = vector.array
	}
	
	
	public init (_ data: [GLfloat]) {
		array = T(data).array
	}
}