//
//  GLTextureMap.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 25.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLTextureMap : GLAttribute {
	var texture : GLTexture {get}
}


/**
Describes the protocol for 2D texture maps
*/
public protocol GLTextureMap2D : GLAttribute {
	
	/// Provides the texture object
	var texture : GLTexImage2D {get}
	
	/// Provides the texture coordinates
	var values : [vec2] {get}
	
	/// Provides a list of tangents for tangent space
	var tangent : GLvarattrib3? {get}
	
	/// Provides a list of tangents for tangent space
	var bitangent : GLvarattrib3? {get}
}