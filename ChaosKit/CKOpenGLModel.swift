//
//  CKOpenGLModel.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLModel {
	
	internal var _position : vec3 = vec3()
	
	internal var _rotation : vec3 = vec3()
	
	public var position : vec3 {get{return _position}}
	
	public var rotation : vec3 {get{return _position}}
	
	
	public var notificationCenter : NSNotificationCenter {
		return NSNotificationCenter.defaultCenter()
	}
	
	
	public func add (observer o: CKOpenGLModelObserver) {
		notificationCenter.addObserver(o, selector: "modelDidMove:", name: CKOpenGLModelEvent.Move.rawValue, object: self)
		
		notificationCenter.addObserver(o, selector: "modelDidRotate:", name: CKOpenGLModelEvent.Rotate.rawValue, object: self)
	}
	
	
	public func notify (type: CKOpenGLModelEvent) {
		var notification : NSNotification = NSNotification(name: type.rawValue, object: self)
		notificationCenter.postNotification(notification)
	}
	
	
	public func moveAndRotate (position p: vec3?, rotation r: vec3?) {
		if nil != p {_position = p!}
		if nil != r {_rotation = r!}
		if nil != p || nil != r {notify(CKOpenGLModelEvent.Change)}
	}
	
	
	public func move (x: GLfloat, y: GLfloat, z: GLfloat) {
		move([x, y, z])
	}
	
	public func move (position: vec3) {
		_position = position
		notify(CKOpenGLModelEvent.Move)
	}
	
	public func rotate (x: GLfloat, y: GLfloat, z: GLfloat) {
		rotate([x, y, z])
	}
	
	public func rotate (rotation: vec3) {
		_rotation = rotation
		notify(CKOpenGLModelEvent.Rotate)
	}
}

@objc
public protocol CKOpenGLModelObserver {
	func modelDidMove (notification: NSNotification)
	func modelDidRotate (notification: NSNotification)
	func modelDidChange (notification: NSNotification)
}

public enum CKOpenGLModelEvent : String {
	case Change = "CKOpenGLModelEvent.Change"
	case Move = "CKOpenGLModelEvent.Move"
	case Rotate = "CKOpenGLModelEvent.Rotate"
}
