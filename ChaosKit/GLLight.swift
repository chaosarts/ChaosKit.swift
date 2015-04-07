//
//  GLLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 31.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class GLLight : GLDisplayObject {
	
	public var color : vec3
	
	public var intensity : GLfloat
	
	public init (color c: vec3, intensity i: GLfloat) {
		self.color = c
		self.intensity = i
	}
}


public class GLDiffusePointlight : GLDisplayObject {
	
}


public class GLSpecularPointlight : GLDisplayObject {
	
}


