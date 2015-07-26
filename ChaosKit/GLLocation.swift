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
public protocol GLLocation : Printable {
	
	/// The varname string in the shader program
	var name : String {get}
}

