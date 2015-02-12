//
//  CKOpenGLPositionedLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 05.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLPositionedLight: CKOpenGLLight {
	
	public var position : vec3
	
	public var x : GLfloat {get {return position.x} set {position.x = newValue}}
	
	public var y : GLfloat {get {return position.y} set {position.y = newValue}}
	
	public var z : GLfloat {get {return position.z} set {position.z = newValue}}
	
	
	public override init() {
		position = vec3()
		super.init()
	}
	
	
	public init(position: vec3, color: RGBColor, intensity: GLfloat)
	{
		self.position = position
		super.init(color: color, intensity: intensity)
	}
	
	
	public init(x: GLfloat, y: GLfloat, z: GLfloat, r: GLfloat, g: GLfloat, b: GLfloat, i: GLfloat)
	{
		position = [x, y, z]
		super.init(r: r, g: g, b: b, i: i)
	}

}
