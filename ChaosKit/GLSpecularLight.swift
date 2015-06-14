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
	
	public override var uniforms : [GLUrl : GLUniform] {
		get {
			if nil == _uniforms {
				_uniforms = [
					GLUrl(.SpecularLight, GLUniformType.Color) : GLUniform4f(color.r, color.g, color.b, intensity),
					GLUrl(.SpecularLight, .Transformation) : GLUniform3f(position.x, position.y, position.z),
					GLUrl(.SpecularLight, .Shinyness) : GLUniform1f(shinyness)
				]
			}
			
			return _uniforms!
		}
	}
	
	public override init () {
		super.init()
	}
}