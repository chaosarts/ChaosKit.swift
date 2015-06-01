//
//  GLAttributeData.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol GLAttribute {
	
	/// Provides the size of an attribute value per vertex
	var size : Int {get}
	
	/// Provides the count of vertices
	var count : Int {get}
	
	/// Contains all vertex attribute data as array
	var array : [GLfloat] {get}
	
	/// Indicates if the attribute is dynamic or not
	var dynamic : Bool {get set}
	
	/// Subscript access to an attribute value of one vertex at given index
	subscript (index: Int) -> [GLfloat] {get}
	
	/// Appends data to the attribute
	func append (data: [GLfloat])
}


public class GLAttributeArray : GLAttribute {
	
	public var _array : [GLfloat] = []
	
	public let size : Int
	
	public var count : Int {get {return _array.count / size}}
	
	public var array : [GLfloat] {get {return _array}}
	
	public var dynamic : Bool = false
	
	public subscript (index: Int) -> [GLfloat]{
		get {return Array<GLfloat>(_array[(size * index)..<((index + 1) * size)])}
	}
	
	public init (size: Int) {
		self.size = size
	}
	
	public func append (data: [GLfloat]) {
		var modulo : Int = data.count % size
		var fillCount : Int = modulo == 0 ? 0 : size - modulo
		
		for index in 0..<(data.count + fillCount) {
			_array.append(data.count > index ? data[index] : 0.0)
		}
	}
}