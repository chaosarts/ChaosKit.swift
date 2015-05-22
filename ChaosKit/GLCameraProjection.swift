//
//  GLCameraProjection.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 07.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Protocol for camera projection
*/
public protocol GLCameraProjection {
	
	/// Provides the projection view matrix
	var viewMatrix : mat4 {get}
	
	/// Provides the view volume of the camera
	var viewVolume : GLViewVolume {get set}
}


/** 
Struct that represents orthographic projection
*/
public struct GLOrthographicProjection : GLCameraProjection {
	
	/// Provides the projection view matrix
	private var _viewMatrix : mat4
	
	/// Provides the projection view matrix
	public var viewMatrix : mat4 {get {return _viewMatrix}}
	
	/// Provides the view volume of the camera
	public var viewVolume : GLViewVolume {
		didSet {
			_viewMatrix = mat4.makeOrtho(left: viewVolume.left, right: viewVolume.right, bottom: viewVolume.bottom, top: viewVolume.top, near: viewVolume.near, far: viewVolume.far)
		}
	}
	
	
	/**
	Initializes the projection with given view volume
	
	:param: viewVolume The view colume object
	*/
	public init (viewVolume: GLViewVolume = GLViewVolume()) {
		self.viewVolume = viewVolume
		_viewMatrix = mat4.makeOrtho(left: viewVolume.left, right: viewVolume.right, bottom: viewVolume.bottom, top: viewVolume.top, near: viewVolume.near, far: viewVolume.far)
	}
}


/**
Struct that represents perspective projection
*/
public struct GLPerspectiveProjection : GLCameraProjection {
	
	/// Provides the projection view matrix
	private var _viewMatrix : mat4
	
	/// Provides the projection view matrix
	public var viewMatrix : mat4 {get {return _viewMatrix}}
	
	/// Provides the view volume of the camera
	public var viewVolume : GLViewVolume {
		didSet {
			_viewMatrix = mat4.makeFrustum(left: viewVolume.left, right: viewVolume.right, bottom: viewVolume.bottom, top: viewVolume.top, near: viewVolume.near, far: viewVolume.far)
		}
	}
	
	
	/**
	Initializes the projection with given view volume
	
	:param: viewVolume The view colume object
	*/
	public init (viewVolume: GLViewVolume = GLViewVolume()) {
		self.viewVolume = viewVolume
		_viewMatrix = mat4.makeFrustum(left: viewVolume.left, right: viewVolume.right, bottom: viewVolume.bottom, top: viewVolume.top, near: viewVolume.near, far: viewVolume.far)
	}
}