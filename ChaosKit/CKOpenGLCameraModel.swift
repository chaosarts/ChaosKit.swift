//
//  CKOpenGLCamera.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/** 
Model class to represent a camera for a opengl scene. The viewport
parameters are readonly outside the model, to prevent setting these
values, to keep observers synchronized to this model. One might
send notification for every single viewport parameter. But mostly one
does not change one parameter at a time. Notifying each observer for
every single parameter would be an overhead.
*/
public class CKOpenGLCameraModel : CKOpenGLModel {
	
	/** Internal left bound of the viewport */
	private var _left : GLfloat = -1
	
	/** Internal right bound of the viewport */
	private var _right : GLfloat = 1
	
	/** Internal bottom bound of the viewport */
	private var _bottom : GLfloat = -1
	
	/** Internal top bound of the viewport */
	private var _top : GLfloat = 1
	
	/** Internal near bound of the viewport */
	private var _near : GLfloat = -1
	
	/** Internal far bound of the viewport */
	private var _far : GLfloat = 1
	
	/** Describes the camera type. Either orthographic or perspective */
	public var type : CKOpenGLCameraType = CKOpenGLCameraType.Orthographic {
		didSet {notify(CKOpenGLCameraEvent.Change)}
	}
	
	/** Readonly left bound of the viewport */
	public var left : GLfloat {get {return _left}}
	
	/** Readonly right bound of the viewport */
	public var right : GLfloat {get {return _right}}
	
	/** Readonly bottom bound of the viewport */
	public var bottom : GLfloat {get {return _bottom}}
	
	/** Readonly top bound of the viewport */
	public var top : GLfloat {get {return _top}}
	
	/** Readonly near bound of the viewport */
	public var near : GLfloat {get {return _near}}
	
	/** Readonly far bound of the viewport */
	public var far : GLfloat {get {return _far}}
	
	/** Contains the centerpoint of the viewport in x, y and z direction*/
	public var center : vec3 {
		get {return vec3((_right + _left) / 2, (_top + _bottom) / 2, (_far + _near) / 2)}
		set {
			var width = self.width
			var height = self.height
			var depth = self.depth
			
			setViewport(
				left: newValue.x - width / 2, right: newValue.x + width / 2,
				bottom: newValue.y - height / 2, top: newValue.y + height / 2,
				near: newValue.z - depth / 2, far: newValue.z + depth / 2
			)
		}
	}
	
	/** Contains the distance between left and right parameter of the viewport*/
	public var width : GLfloat {
		get {return abs(_right - _left)}
		set {
			var center = self.center
			_left = center.x - newValue / 2
			_right = center.x + newValue / 2
		}
	}
	
	/** Contains the distance between bottom and top parameter of the viewport*/
	public var height : GLfloat {
		get {return abs(_top - _bottom)}
		set {
			var center = self.center
			_bottom = center.y - newValue / 2
			_top = center.y + newValue / 2
		}
	}
	
	/** Contains the distance between near and far parameter of the viewport*/
	public var depth : GLfloat {
		get {return abs(_far - _near)}
		set {
			var center = self.center
			_near = center.z - newValue / 2
			_far = center.z + newValue / 2
		}
	}
	
	/** Contains the aspect of the viewport */
	public var aspect : GLfloat {
		get {return width / height}
	}
	
	
	/**
	Initializes the camera with default viewport parameters
 	*/
	convenience public override init () {
		self.init(left: -1, right: 1, bottom: -1, top: 1, near: -1, far: 1)
	}
	
	
	/**
	Initializes the camera with a according viewport parameters
	
	:param: left The left bound of the viewport
	:param: right The right bound of the viewport
	:param: bottom The bottom bound of the viewport
	:param: top The top bound of the viewport
	:param: near The near bound of the viewport
	:param: far The far bound of the viewport
	*/
	public init (left: GLfloat, right: GLfloat, bottom: GLfloat, top: GLfloat, near: GLfloat, far: GLfloat) {
		super.init()
		setViewport(left: left, right: right, bottom: bottom, top: top, near: near, far: far)
	}
	
	
	/**
	Sets the viewport of the camera
	
	:param: left The left bound of the viewport
	:param: right The right bound of the viewport
	:param: bottom The bottom bound of the viewport
	:param: top The top bound of the viewport
	:param: near The near bound of the viewport
	:param: far The far bound of the viewport
	*/
	public func setViewport (left l: GLfloat, right r: GLfloat, bottom b: GLfloat, top t: GLfloat, near n: GLfloat, far f: GLfloat) {
		_left = l
		_right = r
		_bottom = b
		_top = t
		_near = n
		_far = f
	}
	
	
	/**
	Adds a new observer for the camera
	
	:param: observer The observer to add
 	*/
	public func add(observer o: CKOpenGLCameraObserver) {
		super.add(observer: o)
		var selector : Selector = Selector("viewportDidChange:")
		if o.respondsToSelector(selector) {
			notificationCenter.addObserver(o, selector: selector,
				name: CKOpenGLCameraEvent.Change.rawValue, object: self)
		}
	}
	
	
	/** 
	Notifies all observers about a camera event
	
	:param: type An enum value from CKOpenGLCamerEvent
	*/
	public func notify(type: CKOpenGLCameraEvent) {
		var notification : NSNotification = NSNotification(name: type.rawValue, object: self)
		notificationCenter.postNotification(notification)
	}
}


/**
Defines a protocol for camera observers
*/
@objc
public protocol CKOpenGLCameraObserver : CKOpenGLModelObserver, NSObjectProtocol {
	optional func viewportDidChange (notification: NSNotification)
}


/**
Enumerates the type of event names, the camera can dispatch
*/
public enum CKOpenGLCameraEvent : String {
	case Change = "CKOpenGLCameraEvent.Change"
}


/** 
Enumerates the types of cameras
*/
public enum CKOpenGLCameraType : String {
	case Orthographic = "CKOpenGLCameraType.Orthographic"
	case Perspective = "CKOpenGLCameraType.Perspective"
}
