//
//  CKOpenGLCamera.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLCamera: CKOpenGLModel {
	internal var _left : GLfloat = -1
	
	internal var _right : GLfloat = 1
	
	internal var _bottom : GLfloat = -1
	
	internal var _top : GLfloat = 1
	
	internal var _near : GLfloat = -1
	
	internal var _far : GLfloat = 1
	
	public var type : CKOpenGLCameraType = CKOpenGLCameraType.Orthographic {
		didSet {notify(CKOpenGLCameraEvent.Change)}
	}
	
	public var left : GLfloat {get {return _left}}
	
	public var right : GLfloat {get {return _right}}
	
	public var bottom : GLfloat {get {return _bottom}}
	
	public var top : GLfloat {get {return _top}}
	
	public var near : GLfloat {get {return _near}}
	
	public var far : GLfloat {get {return _far}}
	
	public var center : vec3 {
		get {return vec3(x: (_right + _left) / 2, y: (_top + _bottom) / 2, z: (_far + _near) / 2)}
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
	
	public var width : GLfloat {
		get {return abs(_right - _left)}
		set {
			var center = self.center
			_left = center.x - newValue / 2
			_right = center.x + newValue / 2
			notify(CKOpenGLCameraEvent.Change)
		}
	}
	
	public var height : GLfloat {
		get {return abs(_top - _bottom)}
		set {
			var center = self.center
			_bottom = center.y - newValue / 2
			_top = center.y + newValue / 2
			notify(CKOpenGLCameraEvent.Change)
		}
	}
	
	public var depth : GLfloat {
		get {return abs(_far - _near)}
		set {
			var center = self.center
			_near = center.z - newValue / 2
			_far = center.z + newValue / 2
			notify(CKOpenGLCameraEvent.Change)
		}
	}
	
	public var aspect : GLfloat {
		get {return width / height}
	}
	
	convenience public override init () {
		self.init(left: -1, right: 1, bottom: -1, top: 1, near: -1, far: 1)
	}
	
	
	public init (left: GLfloat, right: GLfloat, bottom: GLfloat, top: GLfloat, near: GLfloat, far: GLfloat) {
		super.init()
		setViewport(left: left, right: right, bottom: bottom, top: top, near: near, far: far)
	}
	
	
	public func setViewport (left l: GLfloat, right r: GLfloat, bottom b: GLfloat, top t: GLfloat, near n: GLfloat, far f: GLfloat) {
		_left = l
		_right = r
		_bottom = b
		_top = t
		_near = n
		_far = f
		notify(CKOpenGLCameraEvent.Change)
	}
	
	
	public func add(observer o: CKOpenGLCameraObserver) {
		super.add(observer: o)
		notificationCenter.addObserver(o, selector: "viewportDidChange:", name: CKOpenGLCameraEvent.Change.rawValue, object: self)
	}
	
	
	public func notify(type: CKOpenGLCameraEvent) {
		var notification : NSNotification = NSNotification(name: type.rawValue, object: self)
		notificationCenter.postNotification(notification)
	}
}


public protocol CKOpenGLCameraObserver : CKOpenGLModelObserver {
	func viewportDidChange (notification: NSNotification)
}


public enum CKOpenGLCameraEvent : String {
	case Change = "CKOpenGLCameraEvent.Change"
}


public enum CKOpenGLCameraType {
	case Orthographic
	case Perspective
}
