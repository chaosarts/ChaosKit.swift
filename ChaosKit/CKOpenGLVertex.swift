//
//  CKOpenGLVertex.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 03.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct CKVertex {
	
	public var position : vec3
	
	public var normal : vec3?
	
	public var color : vec4?
	
	public var texCoord : vec2?
	
	
	public init () {
		position = vec3()
	}
	
	
	public init (position: vec3, color: vec4? = nil, normal: vec3? = nil, texCoord: vec2? = nil) {
		self.position = position
		self.color = color
		self.normal = normal
		self.texCoord = texCoord
	}
	
	
	public init (x: GLfloat, y: GLfloat, z: GLfloat) {
		position = [x, y, z]
	}
	
	
	public func array (normal n: Bool, color c: Bool, texCoord t: Bool) -> [GLfloat] {
		var output = position.array
		if n {output += normal!.array}
		if c {output += color!.array}
		if t {output += texCoord!.array}
		return output
	}
}