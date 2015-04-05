//
//  GLStage.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class GLStage : GLContainer {
	
	public var ambientLight : GLAmbientLight?
	
	public var diffuseLights : [GLDiffuseLight] = []
	
	public var specularLights : [GLSpecularLight] = []
	
	public override init () {
		super.init()
	}
	
	public override func addChild(child: GLDisplayObject) {
		super.addChild(child)
		child.stage = self
	}
	
	
	public override func removeChild(child: GLDisplayObject) -> Int {
		var index : Int = super.removeChild(child)
		child.stage = nil
		return index
	}
	
	
	public override func removeChildAt(index: Int) -> GLDisplayObject? {
		var child = super.removeChildAt(index)
		child?.stage = nil
		return child
	}
}
