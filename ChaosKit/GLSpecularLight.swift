//
//  GLAmbientLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLSpecularLight : GLDiffuseLight, GLLight {
	
	public var shinyness : GLfloat = 1
	
	public override var uniforms : [GLurl : GLUniform] {
		get {
			if nil == _uniforms {
				_uniforms = [
					GLurl(.SpecularLight, .Intensity) : GLUniform3f(intensity.r, intensity.g, intensity.b),
					GLurl(.SpecularLight, .Transformation) : GLUniform3f(position.x, position.y, position.z),
					GLurl(.SpecularLight, .Shinyness) : GLUniform1f(shinyness)
				]
			}
			
			return _uniforms!
		}
	}
	
	public override init () {
		super.init()
	}
}