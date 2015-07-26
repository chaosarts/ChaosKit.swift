//
//  CMbase.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct base3 {
	
	public var x : vec3
	
	public var y : vec3
	
	public var z : vec3
	
	public var orthonormalized : base3 {
		get {
			var vectors : [vec3] = gramschmidt(x, y, z)
			return CMbase(vectors[0], vectors[1], vectors[2])
		}
	}
	
	public init (_ x: vec3, _ y: vec3, _ z: vec3) {
		self.x = x
		self.y = y
		self.z = z
	}
}