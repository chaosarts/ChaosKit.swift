//
//  ExtCollectionType.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 14.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public func +<S, T>(left: Dictionary<S, T>, right: Dictionary<S, T>) -> Dictionary<S, T> {
	var result : Dictionary<S, T> = left
	for key in right.keys {
		result[key] = right[key]
	}
	return result
}