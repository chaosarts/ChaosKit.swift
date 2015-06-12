//
//  Identifiable.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol Identifiable {
	var id : Identifier {get}
}

public struct Identifier : Printable, Hashable, StringLiteralConvertible {
	
	private var _value : String
	
	public var description : String {get {return "#" + _value}}
	
	public var hashValue : Int {get {return description.hashValue}}
	
	
	public init (stringLiteral value: StringLiteralType) {
		_value = value
	}
	
	public init (extendedGraphemeClusterLiteral value: StringLiteralType) {
		self.init(stringLiteral: value)
	}
	
	
	
	public init (unicodeScalarLiteral value: StringLiteralType) {
		self.init(stringLiteral: value)
	}
}

public func ==(left: Identifier, right: Identifier) -> Bool {
	return left.hashValue == right.hashValue
}