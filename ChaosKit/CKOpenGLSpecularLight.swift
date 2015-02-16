//
//  CKOpenGLSpecularLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 05.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLSpecularLight: CKOpenGLPositionedLight {
	public var shininess : GLfloat = 1
	
	public init (shininess: GLfloat, position: vec3 = vec3(), color: RGBColor = (1, 1, 1), intensity: GLfloat = 1) {
		self.shininess = shininess
		super.init(position: position, color: color, intensity: intensity)
	}
}
