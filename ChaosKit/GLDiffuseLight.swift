//
//  GLAmbientLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLDiffuseLight : GLAmbientLight, GLLight {
	
	public var position : vec3 = vec3()
	
	public override var uniforms : [GLurl : GLUniform] {
		get {
			if nil == _uniforms {
				_uniforms = [
					GLurl(.DiffuseLight, .Intensity) : GLUniform3f(intensity.r, intensity.g, intensity.b),
					GLurl(.DiffuseLight, .Transformation) : GLUniform3f(position.x, position.y, position.z)
				]
			}
			
			return _uniforms!
		}
	}
	
	public override init () {
		super.init()
	}
}