//
//  GLUniform.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public enum GLUniformAlias : String {
	case ModelViewMatrix = "ModelViewMatrix"
	case ProjectionViewMatrix = "ProjectionViewMatrix"
	
	case AmbientLightColor = "AmbientLightColor"
	case AmbientLightIntensity = "AmbientLightIntensity"
	
	case DiffuseLightColor = "DiffuseLightColor"
	case DiffuseLightPosition = "DiffuseLightPosition"
	case DiffuseLightIntensity = "DiffuseLightIntensity"
	
	case SpecularLightColor = "SpecularLightColor"
	case SpecularLightPosition = "SpecularLightPosition"
	case SpecularLightIntensity = "SpecularLightIntensity"
	case SpecularLightShininess = "SpecularLightShininess"
	
	case Texture = "Texture"
	case ShadowMap = "ShadowMap"
	case BumpMap = "BumpMap"
	case DisplacementMap = "DisplacementMap"
	case HeightMap = "HeightMap"
	case NormalMap = "NormalMap"
	case SpecularMap = "SpecularMap"
	case GlowMap = "GlowMap"
	case EnviromentMap = "EnviromentMap"
	
	static let cases : [GLUniformAlias] = [
		.ModelViewMatrix,
		.ProjectionViewMatrix,
		
		.AmbientLightColor,
		.AmbientLightIntensity,
		
		.DiffuseLightColor,
		.DiffuseLightPosition,
		.DiffuseLightIntensity,
		
		.SpecularLightColor,
		.SpecularLightPosition,
		.SpecularLightIntensity,
		.SpecularLightShininess,
		
		.Texture,
		.ShadowMap,
		.BumpMap,
		.NormalMap,
		.DisplacementMap,
		.HeightMap,
		.SpecularMap,
		.GlowMap,
		.EnviromentMap
	]
}


public struct GLUniformVariable {
	
	public let id : GLuint
	
	public let name : String
	
	public let type : GLenum
	
	public let size : GLint
	
	public init (index: GLuint, name: String, type: GLenum, size: GLint) {
		self.id = index
		self.name = name
		self.type = type
		self.size = size
	}
}
