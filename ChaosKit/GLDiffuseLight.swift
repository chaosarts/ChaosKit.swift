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
	
	public override var uniforms : [GLUrl : GLUniform] {
		get {
			if nil == _uniforms {
				_uniforms = [
					GLUrl(.DiffuseLight, GLUniformType.Color) : GLUniform4f(color.r, color.g, color.b, intensity),
					GLUrl(.DiffuseLight, .Transformation) : GLUniform3f(position.x, position.y, position.z),
				]
			}
			
			return _uniforms!
		}
	}
	
	public override init () {
		super.init()
	}
}