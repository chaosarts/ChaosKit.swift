//
//  CKOpenGLShape.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 16.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct CKOpenGLShape {
	private var _vertice : [CKOpenGLVertexAttributeType : CKOpenGLVertexAttribute<MatrixType>]
		= [CKOpenGLVertexAttributeType : CKOpenGLVertexAttribute<MatrixType>]()
	
	public mutating func addAttribute(attribute: CKOpenGLVertexAttribute<MatrixType>) {
		_vertice[attribute.type] = attribute
	}
}