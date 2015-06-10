//
//  GLAttribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLAttribute : GLBufferable {}

public class GLAttributeDataArray : GLAttribute {
	
	private var _data : [GLfloat] = []
	
	public var attribute : GLAttributeType
	
	public var count : Int {get {return _data.count / size}}
	
	public var size : Int
	
	public var dynamic : Bool = false
	
	public subscript (index: Int) -> [GLfloat] {
		get {
			var i = (index * size)
			return Array(_data[i..<(i + size)])
		}
	}
	
	public init (attribute: GLAttributeType, size: Int) {
		self.size = size
		self.attribute = attribute
	}
}