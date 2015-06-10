//
//  GLLocation.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 02.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public class GLLocation : GLBase {
	
	public let name : String
	
	internal init (_ id: GLuint, _ name: String) {
		self.name = name
		super.init(id)
	}
}