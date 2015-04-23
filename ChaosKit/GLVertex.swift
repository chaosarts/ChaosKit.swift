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
	
	public var attributes : [GLAttribAlias : GLVertexAttribute] {
		get {return _attributes}
	}
	
	public subscript (attribname: GLAttribAlias) -> GLVertexAttribute? {
		get {return _attributes[attribname]}
		set {_attributes[attribname] = newValue}
	}
}


extension GLVertex : Equatable {}

public func == (l: GLVertex, r: GLVertex) -> Bool {
	if l.attributes.keys.array.count != r.attributes.keys.array.count {return false}
	
	for key in l.attributes.keys {
		if r.attributes[key] == nil {return false}
		if r.attributes[key]!.array != l.attributes[key]!.array {return false}
	}
	
	return true
}