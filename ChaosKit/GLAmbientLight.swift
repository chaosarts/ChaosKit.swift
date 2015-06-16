//
//  GLAmbientLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLAmbientLight : GLLightBase, GLLight {
	
	public var uniforms : [GLurl : GLUniform] {
		get {
			if nil == _uniforms {
				_uniforms = [
					GLurl(.AmbientLight, .Intensity) : GLUniform3f(intensity.r, intensity.g, intensity.b)
				]
			}
			
			return _uniforms!
		}
	}

	
	public override init () {
		super.init()
	}
}