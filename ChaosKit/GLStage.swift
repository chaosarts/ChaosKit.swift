//
//  GLStage.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

/*
|--------------------------------------------------------------------------
| Stage class
|--------------------------------------------------------------------------
*/

/** 
Stage class to place display objects
*/
public class GLStage : GLContainer {
	
	
	public var uniforms : [GLurl : GLUniform] {
		get {
			if _uniforms == nil {
				_uniforms = [GLurl : GLUniform]()
			}
			return [GLurl : GLUniform]()
		}
	}
	
	// INITIALIZERS
	// ++++++++++++
	
	/**
	Initializes the stage
	*/
	public override init () {
		super.init()
	}
	
	
	// METHODS
	// ++++++
	
	/**
	Adds a display object to this stage
	
	- parameter child: The object to add
	*/
	public override func addChild(child: GLDisplayObject) {
		super.addChild(child)
		child.stage = self
	}
	
	
	/**
	Removes a child from this stage
	
	- parameter child: The child to remove
	*/
	public override func removeChild(child: GLDisplayObject) -> Int? {
		let index : Int? = super.removeChild(child)
		child.stage = nil
		return index
	}
	
	
	/**
	Removes a child at given index from this stage
	
	- parameter index: The index of the child to remove
	*/
	public override func removeChildAt(index: Int) -> GLDisplayObject? {
		let child = super.removeChildAt(index)
		child?.stage = nil
		return child
	}
}
