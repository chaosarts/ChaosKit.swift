//
//  GLAmbientLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLAmbientLight : GLLightBase, GLLight {
	
	public var intensity : GLfloat {
		didSet {_uniforms[.Intensity] = GLUniform1f(intensity)}
	}
	
	public init (intensity: GLfloat) {
		self.intensity = intensity
		super.init()
		_uniforms[.Intensity] = GLUniform1f(intensity)
	}
}