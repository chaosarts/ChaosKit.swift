//
//  GLAttribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 02.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL


public protocol GLAttribute {
	
	/// Indicates the size per attribute value
	var size : Int {get}
	
	/// Indicates if the attribute is dynamic or static
	var dynamic : Bool {get}
	
	/**
	Returns the value at given index position.
	
	:param: index The index of the value to fetch
	:return: The value at given index
	*/
	func getBufferData (atIndex index: Int) -> [GLfloat]
}