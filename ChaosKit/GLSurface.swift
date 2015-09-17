//
//  GLSurface.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

/**
Surface struct for shapes
*/
public class GLSurface : GLAttributeContainer {
	
	/// Caches the uniforms
	private var _uniforms : [GLurl : GLUniform]?
	
	/// Provides a map of url domain to surface texture
	public private(set) var _textureMaps2D : [GLUrlDomain : GLTextureMap2D] = [GLUrlDomain : GLTextureMap2D]()
	
	/// Returns the count of textures this surface uses
	public var texMap2DCount : Int {get {return _textureMaps2D.count}}
	
	/// Provides the refelction factor
	public var reflection : GLfloat = 0.5
	
	/// Provides the color of the surface
	public var color : GLAttribute?
	
	/// Provides the normals of the surface
	public var normal : GLnormal?
	
	/// Provides the surface texture for bump mapping
	public var colormap : GLTextureMap2D? {
		get {return _textureMaps2D[.ColorMap]}
		set {_textureMaps2D[.ColorMap] = newValue; _uniforms = nil}
	}
	
	/// Provides the surface texture for bump mapping
	public var bumpmap : GLTextureMap2D? {
		get {return _textureMaps2D[.BumpMap]}
		set {_textureMaps2D[.BumpMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var normalmap : GLTextureMap2D? {
		get {return _textureMaps2D[.NormalMap]}
		set {_textureMaps2D[.NormalMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var heightmap : GLTextureMap2D? {
		get {return _textureMaps2D[.HeightMap]}
		set {_textureMaps2D[.HeightMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var displacementmap : GLTextureMap2D? {
		get {return _textureMaps2D[.DisplacementMap]}
		set {_textureMaps2D[.DisplacementMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var glowmap : GLTextureMap2D? {
		get {return _textureMaps2D[.GlowMap]}
		set {_textureMaps2D[.GlowMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var diffusemap : GLTextureMap2D? {
		get {return _textureMaps2D[.DiffuseMap]}
		set {_textureMaps2D[.DiffuseMap] = newValue}
	}
	
	/// Provides the surface texture for bump mapping
	public var specularmap : GLTextureMap2D? {
		get {return _textureMaps2D[.SpecularMap]}
		set {_textureMaps2D[.SpecularMap] = newValue}
	}
	
	/// 
	public var attributeContainers : [GLAttributeContainer] {
		get {
			var containers : [GLAttributeContainer] = []
			return containers
		}
	}
	
	/// Provides the attribute properties
	public var attributes : [GLurl : GLAttribute] {
		get {
			var attributes : [GLurl : GLAttribute] = [GLurl : GLAttribute]()
			if nil != color {attributes[GLUrlSurfaceColor] = color!}
			if nil != normal {attributes[GLUrlVertexNormal] = normal!}
			
			for domain in _textureMaps2D.keys {
				attributes[GLurl(domain, .TexCoord)] = _textureMaps2D[domain]!
				
				if _textureMaps2D[domain]!.tangent != nil {
					attributes[GLurl(domain, .Tangent)] = _textureMaps2D[domain]!.tangent!
					attributes[GLurl(domain, .Bitangent)] = _textureMaps2D[domain]!.bitangent!
				}
			}
			return attributes
		}
	}
	
	
	/// Provides the uniforms to apply to program when using this surface
	public var uniforms : [GLurl : GLUniform] {
		get {
			if nil == _uniforms {
				_uniforms = [GLurl : GLUniform]()
				var index : Int = 0
				for domain in _textureMaps2D.keys {
					if GLint(index) > GL.MAX_COMBINED_TEXTURE_IMAGE_UNITS {
						warn("Max combined texture units exceeded.")
						break
					}
					_uniforms![GLurl(domain, .Sampler)] = GLUniformTexture(_textureMaps2D[domain]!.texture, index)
					index++
				}
				_uniforms![GLUrlSurfaceReflection] = GLuniform1f(reflection)
			}
			
			return _uniforms!
		}
	}
	
	public init () {}
}