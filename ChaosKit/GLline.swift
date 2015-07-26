//
//  GLline.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct GLline : GLPrimitive {
	/// Provides the first point of the line
	public var a : vec3
	
	/// Provides the second point of the line
	public var b : vec3
	
	/// Provides the list of values
	public var values : [vec3] {get {return [a, b]}}
	
	/// Initializes the line
	public init (_ a: vec3, _ b: vec3) {
		self.a = a
		self.b = b
	}
}