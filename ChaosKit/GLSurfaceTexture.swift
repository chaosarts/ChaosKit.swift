//
//  GLSurfaceTexture.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 08.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLSurfaceTexture : GLShapeProperty, GLTextureMap {
	
}

public class GLSurfaceTextureMap2D : GLSurfaceTexture {
	
	private var _texture : GLTexture2D
	
	public var coords : [vec2] = []
	
	public var count : Int {get {return coords.count}}
	
	public let size : Int = 2
	
	public var dynamic : Bool = false
	
	public var texture : GLTexture {get {return _texture}}
	
	public var indexed : Bool = false
	
	
	public subscript (index: Int) -> [GLfloat] {
		get {return coords[index].array}
	}
	
	public init (texture: GLTexture2D, coords: [vec2]) {
		_texture = texture
	}
}