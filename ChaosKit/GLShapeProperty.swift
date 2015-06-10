//
//  GLShapeProperty.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLShapeProperty : GLBufferable {}

public class GLShapePropertyArray<V: Vector> : GLShapeProperty, ArrayLiteralConvertible  {
	
	public var values : [V] = []
	
	public var count : Int {get {return values.count}}
	
	public var size : Int {get {return V.elementCount}}
	
	public var dynamic : Bool = false
	
	public subscript () -> V {
		get {return V()}
		set {values.append(newValue)}
	}
	
	public subscript (index: Int) -> [GLfloat] {
		get {return values[index].array}
	}
	
	
	public convenience init () {
		self.init(values: [])
	}
	
	public init (values: [V]) {
		self.values = values
	}
	
	
	public convenience required init(arrayLiteral elements: V...) {
		self.init(values: elements)
	}
}