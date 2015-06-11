//
//  GLAmbientLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLSpecularLight : GLDiffuseLight, GLLight {
	
	public var shinyness : GLfloat {
		didSet {_uniforms[.Shinyness] = GLUniform1f(shinyness)}
	}
	
	public init (intensity: GLfloat, position: vec3, shinyness: GLfloat) {
		self.shinyness = shinyness
		super.init(intensity: intensity, position: position)
		_type = .Specular
		_uniforms[.Shinyness] = GLUniform1f(shinyness)
	}
}