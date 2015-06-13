//
//  GLView.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import AppKit

@objc public class GLView : NSOpenGLView {
	
	private var application : GLApplication = GLApplication()
	
	public override func prepareOpenGL() {
		super.prepareOpenGL()
	}
}