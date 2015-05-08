//
//  GLRenderpassCapability.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 03.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct GLCapability {
	
	public let type : GLenum
	
	private let _apply : (cap: GLenum) -> Void
	
	public init (_ type: Int32, _ enable: Bool) {
		self.type = GLenum(type)
		_apply = enable ? glEnable : glDisable
	}
	
	
	public func apply () {
		_apply(cap: type)
	}
}