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
	var volume : GLViewVolume {get set}
	
	/// Provides essential values of the projection as uniforms to pass to program
	var uniforms : [GLLocationSelector : GLUniform] {mutating get}
}


/** 
Struct that represents orthographic projection
*/
public struct GLOrthographicProjection : GLCameraProjection {
	
	/// Provides the projection view matrix
	private var _matrix : mat4
	
	/// Caches the public uniforms property
	private var _uniforms : [GLLocationSelector : GLUniform]?
	
	/// Provides the projection view matrix
	public var matrix : mat4 {get {return _matrix}}
	
	/// Provides the view volume of the camera
	public var volume : GLViewVolume {
		didSet {
			_matrix = mat4.makeOrtho(left: volume.left, right: volume.right, bottom: volume.bottom, top: volume.top, near: volume.near, far: volume.far)
		}
	}
	
	/// Provides essential values of the projection as uniforms to pass to program
	public var uniforms : [GLLocationSelector : GLUniform] {
		mutating get {
			if nil == _uniforms {
				_uniforms = [GLLocationSelector : GLUniform]()
				var selector : GLLocationSelector = GLLocationSelector(type: .ProjectionViewMatrix);
				_uniforms![selector] = GLUniformMatrix4fv(_matrix)
			}
			return _uniforms!
		}
	}
	
	
	/**
	Initializes the projection with given view volume
	
	:param: viewVolume The view colume object
	*/
	public init (_ volume: GLViewVolume = GLViewVolume()) {
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
	
	/// Caches the public uniforms property
	private var _uniforms : [GLLocationSelector : GLUniform]?
	
	/// Provides the projection view matrix
	public var matrix : mat4 {get {return _matrix}}
	
	/// Provides the view volume of the camera
	public var volume : GLViewVolume {
		didSet {
			_matrix = mat4.makeFrustum(left: volume.left, right: volume.right, bottom: volume.bottom, top: volume.top, near: volume.near, far: volume.far)
		}
	}
	
	/// Provides essential values of the projection as uniforms to pass to program
	public var uniforms : [GLLocationSelector : GLUniform] {
		mutating get {
			if nil == _uniforms {
				_uniforms = [GLLocationSelector : GLUniform]()
				var selector : GLLocationSelector = GLLocationSelector(type: .ProjectionViewMatrix);
				_uniforms![selector] = GLUniformMatrix4fv(_matrix)
			}
			return _uniforms!
		}
	}
	
	
	/**
	Initializes the projection with given view volume
	
	:param: viewVolume The view colume object
	*/
	public init (_ viewVolume: GLViewVolume = GLViewVolume()) {
		self.volume = viewVolume
		_matrix = mat4.makeFrustum(left: viewVolume.left, right: viewVolume.right, bottom: viewVolume.bottom, top: viewVolume.top, near: viewVolume.near, far: viewVolume.far)
	}
}