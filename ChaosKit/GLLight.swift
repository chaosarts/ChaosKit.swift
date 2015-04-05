//
//  GLLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 31.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public struct GLAmbientLight {
	public var color : vec3
}


public struct GLDiffuseLight {
	public var color : vec3
	public var position : vec3
}


public struct GLSpecularLight {
	public var color : vec3
	public var position : vec3
}
