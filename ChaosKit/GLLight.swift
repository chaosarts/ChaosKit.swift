//
//  GLLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 31.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class GLLight {
	
	public var color : vec3
	
	public var intensity : GLfloat
	
	
	public init (color c: vec3, intensity i: GLfloat) {
		self.color = c
		self.intensity = i
	}
	
	
	public convenience init () {
		self.init(color: [255, 255, 255], intensity: 1)
	}
}


public class GLDiffuselight : GLLight {
	
	public var position : vec3
	
	public init (position p: vec3, color c: vec3, intensity i: GLfloat) {
		position = c
		super.init(color: c, intensity: i)
	}
	
	public convenience init () {
		self.init(position: [0, 0, 0], color: [255, 255, 255], intensity: 1)
	}
}


public class GLSpecularlight : GLDisplayObject {
	
}


