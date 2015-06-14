//
//  GLAmbientLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLAmbientLight : GLLightBase, GLLight {
	
	public var uniforms : [GLUrl : GLUniform] {
		get {
			if nil == _uniforms {
				_uniforms = [
					GLUrl(.AmbientLight, GLUniformType.Color) : GLUniform4f(color.r, color.g, color.b, intensity)
				]
			}
			
			return _uniforms!
		}
	}

	
	public override init () {
		super.init()
	}
}