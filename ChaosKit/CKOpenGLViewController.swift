//
//  CKOpenGLViewController.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLViewController : NSResponder {
	
	public var view : CKOpenGLView? {
		didSet {view!.nextResponder = self}
	}
	
	public var model : CKOpenGLModel? {
		didSet {model!.add(observer: self)}
	}
	
	public override init () {
		super.init()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}


extension CKOpenGLViewController : CKOpenGLModelObserver {}
