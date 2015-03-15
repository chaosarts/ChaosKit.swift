//
//  Light.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 05.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol LightType : Colorable {
	var intensity : GLfloat {get set}
	var r : GLfloat {get set}
	var g : GLfloat {get set}
	var b : GLfloat {get set}
}

public class AmbientLight : LightType {
		
	public var color : vec4
	
	public var intensity : GLfloat
	
	public var r : GLfloat {get {return color.x} set {color.x = newValue}}
	
	public var g : GLfloat {get {return color.y} set {color.y = newValue}}
	
	public var b : GLfloat {get {return color.z} set {color.z = newValue}}
	
	
	public convenience init () {
		self.init(color: [1, 1, 1], intensity: 1)
	}
	
	
	public convenience init (r: GLfloat, g: GLfloat, b: GLfloat, i: GLfloat) {
		self.init(color: [r, g, b], intensity: i)
	}
	
	
	public init (color: vec4, intensity: GLfloat) {
		self.color = color
		self.intensity = intensity
	}
}


public class DiffuseLight : AmbientLight, Placeable {
	public var position : vec3
	
	public init (color: vec4, intensity: GLfloat, position: vec3) {
		self.position = position
		super.init(color: color, intensity: intensity)
	}
}


public class SpecularLight : DiffuseLight {
	public var shininess : Int
	
	public init (color: vec4, intensity: GLfloat, position: vec3, shininess: Int) {
		self.shininess = shininess
		super.init(color: color, intensity: intensity, position: position)
	}
}