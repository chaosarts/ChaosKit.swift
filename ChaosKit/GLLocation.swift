//
//  GLLocation.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 02.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

/*
|--------------------------------------------------------------------------
| Location Class
|--------------------------------------------------------------------------
*/

/**
Base class for shader program locations
*/
public class GLLocation : GLBase, Printable {
	
	/// The varname string in the shader program
	public let name : String
	
	public var description : String {
		get {return "\(name) (id: \(id))"}
	}
	
	/**
	Initializes the location with passed id (index) and varname
	*/
	internal init (_ id: GLuint, _ name: String) {
		self.name = name
		super.init(id)
	}
}

