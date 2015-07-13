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
	var matrix : mat4 {get}
	
	/// Provides the view volume of the camera
	var volume : GLvolume {get set}
}


/** 
Struct that represents orthographic projection
*/
public struct GLOrthographicProjection : GLCameraProjection {
	
	/// Provides the projection view matrix
	private var _matrix : mat4
	
	/// Provides the projection view matrix
	public var matrix : mat4 {get {return _matrix}}
	
	/// Provides the view volume of the camera
	public var volume : GLvolume {
		didSet {
			_matrix = mat4.makeOrtho(left: volume.left, right: volume.right, bottom: volume.bottom, top: volume.top, near: volume.near, far: volume.far)
		}
	}
	
	
	/**
	Initializes the projection with given view volume
	
	:param: viewVolume The view colume object
	*/
	public init (_ volume: GLvolume = GLvolume()) {
		self.volume = volume
		_matrix = mat4.makeOrtho(left: volume.left, right: volume.right, bottom: volume.bottom, top: volume.top, near: volume.near, far: volume.far)
	}
}


/**
Struct that represents perspective projection
*/
public struct GLPerspectiveProjection : GLCameraProjection {
	
	/// Provides the projection view matrix
	private var _matrix : mat4
	
	/// Provides the projection view matrix
	public var matrix : mat4 {get {return _matrix}}
	
	/// Provides the view volume of the camera
	public var volume : GLvolume {
		didSet {
			_matrix = mat4.makeFrustum(left: volume.left, right: volume.right, bottom: volume.bottom, top: volume.top, near: volume.near, far: volume.far)
		}
	}
	
	
	/**
	Initializes the projection with given view volume
	
	:param: viewVolume The view colume object
	*/
	public init (_ viewVolume: GLvolume = GLvolume()) {
		self.volume = viewVolume
		_matrix = mat4.makeFrustum(left: viewVolume.left, right: viewVolume.right, bottom: viewVolume.bottom, top: viewVolume.top, near: viewVolume.near, far: viewVolume.far)
	}
}