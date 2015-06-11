//
//  GLDisplayObjectId.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct GLDisplayObjectId : Printable, IntegerLiteralConvertible, StringLiteralConvertible {
	
	public let description : String
	
	public init () {
		self.init(stringLiteral: GLDisplayObjectManager.getInstance().generateId().description)
	}
	
	
	public init(stringLiteral value: StringLiteralType) {
		description = value
	}
	
	
	public init(unicodeScalarLiteral value: String) {
		self.init(stringLiteral: value)
	}
	
	
	public init(extendedGraphemeClusterLiteral value: String) {
		self.init(stringLiteral: value)
	}
	
	
	public init(integerLiteral value: IntegerLiteralType) {
		self.init(stringLiteral: value.description)
	}
}