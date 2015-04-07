//
//  GLCameraProjection.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLCameraProjection {
	var viewMatrix : mat4 {get}
	
	var viewVolume : GLViewVolume {get}
}


public struct GLOrthographicProjection : GLCameraProjection {
	
	private var _viewMatrix : mat4
	
	public var viewMatrix : mat4 {get {return _viewMatrix}}
	
	public var viewVolume : GLViewVolume {
		didSet {
			_viewMatrix = mat4.makeOrtho(left: viewVolume.left, right: viewVolume.right, bottom: viewVolume.bottom, top: viewVolume.top, near: viewVolume.near, far: viewVolume.far)
		}
	}
	
	public init (viewVolume: GLViewVolume) {
		_viewMatrix = mat4.identity
		self.viewVolume = viewVolume
	}
}


public struct GLPerspectiveProjection : GLCameraProjection {
	private var _viewMatrix : mat4
	
	public var viewMatrix : mat4 {get {return _viewMatrix}}
	
	public var viewVolume : GLViewVolume {
		didSet {
			_viewMatrix = mat4.makeFrustum(left: viewVolume.left, right: viewVolume.right, bottom: viewVolume.bottom, top: viewVolume.top, near: viewVolume.near, far: viewVolume.far)
		}
	}
	
	public init (viewVolume: GLViewVolume) {
		_viewMatrix = mat4.identity
		self.viewVolume = viewVolume
	}
}