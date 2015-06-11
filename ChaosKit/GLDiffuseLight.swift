//
//  GLAmbientLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLDiffuseLight : GLAmbientLight, GLLight {
	
	public override var position : vec3 {
		didSet {_uniforms[.Position] = GLUniform3f(position.x, position.y, position.z)}
	}
	
	public init (intensity: GLfloat, position: vec3) {
		super.init(intensity: intensity)
		self.position = position
		_type = .Diffuse
		_uniforms[.Position] = GLUniform3f(position.x, position.y, position.z)
	}
}