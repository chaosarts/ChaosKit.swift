//
//  GLSphereCreator.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 21.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GLSphereCreator : GLShapeCreator {
	
	/// The radius of the sphere
	public var radius : GLfloat = 1
	
	public var latCount : Int = 10
	
	public var lngCount : Int = 10
	
	public func create () -> GLShape {
		var shape : GLShape = GLShape()
		
		var lngStep : GLfloat = GLfloat(M_PI * 2.0) / GLfloat(lngCount)
		var latStep : GLfloat = GLfloat(M_PI * 2.0) / GLfloat(lngCount)
		
		
		// Upper polar cap
		var top : vec3 = polar2cartesian(radius, 0, 0)
		
		for lat in 0..<latCount {
			shape.normal = top
			shape.createVertex(top)
			
			shape.normal = polar2cartesian(radius, lngStep, GLfloat(lat) * latStep)
			shape.createVertex(shape.normal!)
			
			shape.normal = polar2cartesian(radius, lngStep, GLfloat(lat + 1) * latStep)
			shape.createVertex(shape.normal!)
		}
		
		
		// Body
		
		for lng in 1..<lngCount {
			for lat in 0..<latCount {
				
				// Calculate radians once
				
				let top : GLfloat = GLfloat(lng) * lngStep
				let bottom : GLfloat = GLfloat(lng + 1) * lngStep
				let left : GLfloat = GLfloat(lat) * latStep
				let right : GLfloat = GLfloat(lat + 1) * latStep
				
				
				// Generate vertex coords once
				
				let topLeft : vec3 = polar2cartesian(radius, top, left)
				let bottomLeft : vec3 = polar2cartesian(radius, bottom, left)
				let topRight : vec3 = polar2cartesian(radius, top, right)
				let bottomRight : vec3 = polar2cartesian(radius, bottom, right)
				
				
				// Upper triangle
				
				shape.normal = topLeft
				shape.createVertex(shape.normal!)
				
				shape.normal = bottomLeft
				shape.createVertex(shape.normal!)
				
				shape.normal = bottomRight
				shape.createVertex(shape.normal!)
				
				
				// Lower triangle
				
				shape.normal = topLeft
				shape.createVertex(shape.normal!)
				
				shape.normal = bottomRight
				shape.createVertex(shape.normal!)
				
				shape.normal = topRight
				shape.createVertex(shape.normal!)
			}
		}
		
		
		// Lower polar cap
		
		var bottom : vec3 = polar2cartesian(radius, lngStep * GLfloat(lngCount), 0)
		var theta : GLfloat = lngStep * GLfloat(lngCount - 1)
		
		for lat in 0..<latCount {
			shape.normal = polar2cartesian(radius, theta, GLfloat(lat) * latStep)
			shape.createVertex(shape.normal!)
			
			shape.normal = bottom
			shape.createVertex(shape.normal!)
			
			shape.normal = polar2cartesian(radius, theta, GLfloat(lat + 1) * latStep)
			shape.createVertex(shape.normal!)
		}
		
		return shape
	}
}