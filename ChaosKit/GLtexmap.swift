//
//  GLSurfaceTexture.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 08.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLSurfaceTexture : GLShapeProperty {
	var texture : GLTexture {get}
}

public struct GLtexmap2 : GLSurfaceTexture {
	
	public var size : Int {get {return 2}}
	
	public private(set) var texture : GLTexture
	
	public private(set) var coords : [vec2]

	public var dynamic : Bool = false

	
	public subscript () -> vec2 {
		get {return vec2()}
		set {coords.append(newValue)}
	}
	
	public subscript (index: Int) -> [GLfloat] {
		get {return coords[index].array}
	}
	
	public init (_ texture: GLTexture, _ coords : [vec2]) {
		self.texture = texture
		self.coords = coords
	}
	
	
	public init (_ texture: GLTexture) {
		self.init(texture, [])
	}
}