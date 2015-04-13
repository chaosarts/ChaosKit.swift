//
//  Sphere.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 19.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GLSphereShaper : GLShaper {
	
	public var grain : Int
	
	public var radius : GLfloat
	
	public var defaultColor : vec4 = []
	
	public var mapColor : ((phi: GLfloat, rho: GLfloat) -> vec4)?
	
	public var mapTexCoord : ((phi: GLfloat, rho: GLfloat) -> vec2)?
	
	
	public init (grain g: Int = 10, radius r: GLfloat = 1) {
		grain = g
		radius = r
	}
	
	
	public func form () -> GLShape {
		var shape : GLShape = GLShape()
		shape.extend(getVertice())
		return shape
	}
	
	
	private func getVertice () -> [GLVertex]{
		var vertice : [GLVertex] = []
		var steps : GLfloat = GLfloat(M_2_PI) / GLfloat(grain - 1)
		
		for lat in 0..<grain {
			for lng in 0..<grain {
				var vertex : GLVertex = GLVertex()

				var phi : GLfloat = GLfloat(lat) * steps
				var rho : GLfloat = GLfloat(lng) * steps

				vertex[.Position] = GLVertexAttributeData<vec3>(polar2cartesian(radius, phi, rho))
				vertex[.Color] = GLVertexAttributeData<vec4>(getColor(phi: phi, rho: rho))
				vertex[.Normal] = GLVertexAttributeData<vec3>(vertex[.Position]!.array)
				vertex[.TexCoord] = GLVertexAttributeData<vec2>(getTexCoord(phi: phi, rho: rho))
				vertice.append(vertex)
				
				if lat == 0 || lat == grain {break}
			}
		}
		
		return vertice
	}
	
	
	private func getIndices () -> [Int] {
		var indexlist : [Int] = []
		
		/// For the top pole
		for lng in 0..<grain {
			indexlist.append(0)
			indexlist.append(lng + 1)
			indexlist.append((lng + 1) % grain + 1)
		}
		
		for lat in 1..<(grain - 2) {
			for lng in 0..<grain {
				indexlist.append((lat - 1) * grain + 1 + lng)
				indexlist.append(lat * grain + 1 + lng)
				indexlist.append(lat * grain + 1 + (lng + 1) % grain)
				
				indexlist.append((lat - 1) * grain + 1 + lng)
				indexlist.append(lat * grain + 1 + (lng + 1) % grain)
				indexlist.append((lat - 1) * grain + 1 + (lng + 1) % grain)
			}
		}
		
		/// For the bottom pole
		for lng in 0..<grain {
			indexlist.append(lng + grain * (grain - 3) + 1)
			indexlist.append((lng + 1) % grain + grain * (grain - 3) + 1)
			indexlist.append((grain - 2) * grain + 1)
		}
		
		return indexlist
	}
	
	
	private func getColor (phi p: GLfloat, rho r: GLfloat) -> vec4 {
		if mapColor != nil {return mapColor!(phi: p, rho: r)}
		return defaultColor
	}
	
	
	private func getTexCoord (phi p: GLfloat, rho r: GLfloat) -> vec2 {
		if mapTexCoord != nil {return mapTexCoord!(phi: p, rho: r)}
		return []
	}
}