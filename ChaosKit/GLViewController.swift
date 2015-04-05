//
//  GLDisplayObjectController.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 26.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class GLViewController: NSObject {
	
	public var view : GLDisplayable
	
	public init (view v: GLDisplayable) {
		view = v
		super.init()
	}
}
