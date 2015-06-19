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


public struct GLtex<V: Vector> : GLSurfaceTexture {
	
	public var size : Int {get {return V.elementCount}}
	
	public private(set) var texture : GLTexture
	
	public private(set) var coords : [V]

	public var dynamic : Bool = false

	
	public subscript () -> V {
		get {return V()}
		set {coords.append(newValue)}
	}
	
	public subscript (index: Int) -> [GLfloat] {
		get {return coords[index].array}
	}
	
	public init (_ texture: GLTexture, _ coords : [V]) {
		self.texture = texture
		self.coords = coords
	}
	
	
	public init (_ texture: GLTexture) {
		self.init(texture, [])
	}
}


public typealias GLtex1 = GLtex<vec1>
public typealias GLtex2 = GLtex<vec2>
public typealias GLtex3 = GLtex<vec3>