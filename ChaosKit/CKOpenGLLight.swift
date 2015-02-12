//
//  CKOpenGLLight.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 05.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class CKOpenGLLight {
		
	public var color : RGBColor
	
	public var intensity : GLfloat
	
	public var r : GLfloat {get {return color.r} set {color.r = newValue}}
	
	public var g : GLfloat {get {return color.g} set {color.g = newValue}}
	
	public var b : GLfloat {get {return color.b} set {color.b = newValue}}
	
	
	public init () {
		color = (0, 0, 0)
		intensity = 1
	}
	
	
	public init (color: RGBColor, intensity: GLfloat) {
		self.color = color
		self.intensity = intensity
	}
	
	
	public init (r: GLfloat, g: GLfloat, b: GLfloat, i: GLfloat) {
		color = (r, g, b)
		intensity = i
	}
}