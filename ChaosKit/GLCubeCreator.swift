//
//  GLCubeCreator.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 18.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GLCubeCreator : GLShapeCreator {
	
	public var length : GLfloat
	
	public var color : (position: vec3) -> vec4
	
	public init (length: GLfloat = 1) {
		self.length = length
		self.color = {(position: vec3) in return vec4(0.8, 0.8, 0.8, 1)}
	}
	
	public func create() -> GLShape {
		var shape : GLShape = GLShape()
		
		var normals : [vec3] = [
			vec3(1,0,0),
			vec3(0,1,0),
			vec3(0,0,1)
		]
		
		for index in 0..<(normals.count) {
			var normal : vec3 = normals[index]
			var tangent : vec3 = normals[index % normals.count]
			var bitangent : vec3 = normal • tangent
		}
		
		return shape
	}
}