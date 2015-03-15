//
//  Model.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa


public protocol ModelType : Placeable, Rotateable {

}

/**
OpenGLBase model class for opengl objects. A model contains a position and a rotation and
notifies its observer about its changes. Notifications will be posted even if a
single components of these properties are changed. So care must be taken, if you want
to update more than just one component. Otherwise the model posts notifications for
every single component you change. It's recommended to replace the whole vector, if you want
to change more than one component before notifying observer.
*/
public class Model : ModelType {
	
	/** Indicates if notifying observers is allowed in didSet{} */
	private final var _allowNotification : Bool = true
	
	/** Provides the position of the model in space of parent object */
	public final var position : vec3 = vec3() {
		didSet {if _allowNotification {notify(ModelEvent.Move)}}
	}
	
	/** Provides the rotation of the model in space of parent object */
	public final var rotation : vec3 = vec3() {
		didSet {if _allowNotification {notify(ModelEvent.Rotate)}}
	}
	
	/** The default notification center to post notifications to model observers */
	public lazy var notificationCenter : NSNotificationCenter = NSNotificationCenter.defaultCenter()
	
	
	/** 
	Adds a new model observer 
	
	:param: observer The observer for this model to add
	*/
	public func add (observer o: ModelObserver) {
		var selector : Selector
		
		selector = Selector("modelDidMove:")
		if o.respondsToSelector(selector) {
			notificationCenter.addObserver(o, selector: selector,
				name: ModelEvent.Move.rawValue, object: self)
		}
		
		selector = Selector("modelDidRotate:")
		if o.respondsToSelector(selector) {
			notificationCenter.addObserver(o, selector: selector,
				name: ModelEvent.Rotate.rawValue, object: self)
		}
		
		selector = Selector("modelDidChange:")
		if o.respondsToSelector(selector) {
			notificationCenter.addObserver(o, selector: selector,
				name: ModelEvent.Rotate.rawValue, object: self)
		}
	}
	
	
	/** 
	Posts a notification to observers about a model event
	*/
	public func notify (type: ModelEvent) {
		var notification : NSNotification = NSNotification(name: type.rawValue, object: self)
		notificationCenter.postNotification(notification)
		_allowNotification = true
	}
	
	
	/**
	Moves the model relative by the given direction
	
	:param: x The direction to move to relativly along the x axis
	:param: y The direction to move to relativly along the y axis
	:param: z The direction to move to relativly along the z axis
	*/
	public func moveBy (x mx: GLfloat, y my: GLfloat, z mz: GLfloat) {
		moveBy(direction: [mx, my, mz])
	}
	
	
	/**
	Moves the model relative by the given direction
	
	:param: direction The direction to move to relativly
	*/
	public func moveBy (direction d: vec3) {
		position = position + d
	}
	
	
	/**
	Rotates the model relative by the given rotation
	
	:param: x The relative rotation around the x axis
	:param: y The relative rotation around the y axis
	:param: z The relative rotation around the z axis
	*/
	public func rotateBy (x rx: GLfloat, y ry: GLfloat, z rz: GLfloat) {
		rotateBy(rotation: [rx, ry, rz])
	}
	
	
	/**
	Rotates the model relative by the given rotation
	
	:param: rotation The rotation to rotate relativly
	*/
	public func rotateBy (rotation r: vec3) {
		rotation = rotation + r
	}
	
	
	/**
	Move and rotates the model relative. Notifies only modelevent 'Change'
	
	:param: mx The movement in x direction
	:param: my The movement in y direction
	:param: mz The movement in z direction
	:param: rx The rotation around the x axis
	:param: ry The rotation around the y axis
	:param: rz The rotation around the z axis
	*/
	public final func moveAndRotateBy (mx movx: GLfloat, my movy: GLfloat, mz movz: GLfloat,
		rx rotx: GLfloat, ry roty: GLfloat, rz rotz: GLfloat) {
			moveAndRotateBy(position: [movx, movy, movz], rotation: [rotx, roty, rotz])
	}
	
	
	/**
	Move and rotates the model relative. Notifies only modelevent 'Change'
	
	:param: position The position to move to
	:param: rotation The rotation to rotate
	*/
	public final func moveAndRotateBy (position p: vec3, rotation r: vec3) {
		moveAndRotate(position: position + p, rotation: rotation + r)
	}
	
	
	/**
	Move and rotates the model. Notifies only modelevent 'Change'
	
	:param: mx The movement in x direction
	:param: my The movement in y direction
	:param: mz The movement in z direction
	:param: rx The rotation around the x axis
	:param: ry The rotation around the y axis
	:param: rz The rotation around the z axis
	*/
	public final func moveAndRotate (mx movx: GLfloat, my movy: GLfloat, mz movz: GLfloat,
		rx rotx: GLfloat, ry roty: GLfloat, rz rotz: GLfloat) {
			moveAndRotate(position: [movx, movy, movz], rotation: [rotx, roty, rotz])
	}
	
	
	/**
	Move and rotates the model. Notifies only modelevent 'Change'
	
	:param: position The position to move to
	:param: rotation The rotation to rotate
	*/
	public final func moveAndRotate (position p: vec3, rotation r: vec3) {
		_allowNotification = false
		position = p
		rotation = r
		notify(ModelEvent.Change)
	}
}

/**
Protocol for a model observer
*/
@objc
public protocol ModelObserver : NSObjectProtocol {
	optional func modelDidMove (notification: NSNotification)
	optional func modelDidRotate (notification: NSNotification)
	optional func modelDidChange (notification: NSNotification)
}


/**
Enumerates the types of events, which a opengl model may post
*/
public enum ModelEvent : String {
	case Change = "ModelEvent.Change"
	case Move = "ModelEvent.Move"
	case Rotate = "ModelEvent.Rotate"
}
