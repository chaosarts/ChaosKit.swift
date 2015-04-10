//
//  GLCanvas.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 29.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL
import GLKit


public class GLCanvas: NSOpenGLView {
	
	public func add (obeserver o: GLCanvasObserver) {
		var notificationCenter : NSNotificationCenter = NSNotificationCenter.defaultCenter();
		var selector : Selector = Selector("canvasDidResize:")
		
		if o.respondsToSelector(selector) {
			notificationCenter.addObserver(o, selector: selector, name: GLCanvasEvent.Resize.rawValue, object: self)
		}
	}
	
	
    override public func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
		var notificationCenter : NSNotificationCenter = NSNotificationCenter.defaultCenter();
		var notification : NSNotification = NSNotification(name: GLCanvasEvent.Resize.rawValue, object: self)
		
		notificationCenter.postNotification(notification)
    }
}



public enum GLCanvasEvent : String {
	case Resize = "GLCanvasEvent.Resize"
}

@objc
public protocol GLCanvasObserver : NSObjectProtocol {
	optional func canvasDidResize (notification: NSNotification)
}