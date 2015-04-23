//
//  GLVertexAttribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 14.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol GLVertexAttribute {
	var array : [GLfloat] {get}
}


public struct GLVertexAttributeData<T: Vector> : GLVertexAttribute {
	
	typealias Type = T
	
	public let array : [GLfloat]
	
	public init (_ vector: T) {
		array = vector.array
	}
	
	
	public init (_ data: [GLfloat]) {
		array = T(data).array
	}
}