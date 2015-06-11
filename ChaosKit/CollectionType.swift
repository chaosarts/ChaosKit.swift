//
//  CCCollectionType.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Protocol for collection types
*/
public protocol CollectionType {
	typealias Element
	
	var array : [Element] {get}
	
	var count : Int {get}
	
	var isEmpty : Bool {get}
}


/**
Protocol for count limited structs
*/
public protocol CountLimited {
	typealias Element
	
	var max : Int {get}
	
	var full : Bool {get}
	
	mutating func removeAll () -> [Element]
}