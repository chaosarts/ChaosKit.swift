//
//  Valuable.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/// Protocol for valuable types
public protocol Valuable {
	
	typealias Element
	
	/// The value of the object
	var value : Element {get set}
}