//
//  GLTextureMap.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Enumeration of texture map types supported by this framework
*/
public enum GLTextureMapType : String {
	/// Represents a color texture map
	case ColorMap = "ColorMap"
	
	/// Represents a diffuse texture map
	case DiffuseMap = "DiffuseMap"
	
	/// Represents a normal texture map
	case NormalMap = "NormalMap"
	
	/// Represents a bump texture map
	case BumpMap = "BumpMap"
	
	/// Represents a height texture map
	case HeightMap = "HeightMap"
	
	/// Represents a displacement texture map
	case DisplacementMap = "DisplacementMap"
	
	/// Represents a specular texture map
	case SpecularMap = "SpecularMap"
	
	/// Represents a glow texture map
	case GlowMap = "GlowMap"
}

/**

*/
public protocol GLTextureMap : GLBufferable {
	var texture : GLTexture {get}
}