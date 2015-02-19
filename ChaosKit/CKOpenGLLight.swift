//
//  CKOpenGLLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 05.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class CKOpenGLAmbientLight {
		
	public var color : RGBColor
	
	public var intensity : GLfloat
	
	public var r : GLfloat {get {return color.r} set {color.r = newValue}}
	
	public var g : GLfloat {get {return color.g} set {color.g = newValue}}
	
	public var b : GLfloat {get {return color.b} set {color.b = newValue}}
	
	
	public convenience init () {
		self.init(color: (1, 1, 1), intensity: 1)
	}
	
	
	public convenience init (r: GLfloat, g: GLfloat, b: GLfloat, i: GLfloat) {
		self.init(color: (r, g, b), intensity: i)
	}
	
	
	public init (color: RGBColor, intensity: GLfloat) {
		self.color = color
		self.intensity = intensity
	}
}


public class CKOpenGLDiffuseLight : CKOpenGLAmbientLight {
	public var position : vec3
	
	public init (color: RGBColor, intensity: GLfloat, position: vec3) {
		self.position = position
		super.init(color: color, intensity: intensity)
	}
}


public class CKOpenGLSpecularLight : CKOpenGLDiffuseLight {
	public var shininess : Int
	
	public init (color: RGBColor, intensity: GLfloat, position: vec3, shininess: Int) {
		self.shininess = shininess
		super.init(color: color, intensity: intensity, position: position)
	}
}