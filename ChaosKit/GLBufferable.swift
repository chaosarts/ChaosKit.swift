//
//  GLAttribute.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 02.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLBufferable {
	
	/// Indicates the size per vertex
	var size : Int {get}
	
	/// Indicates if the bufferable is dynamic or static
	var dynamic : Bool {get}
	
	/// Returns the attribute value for a vertex at given index position
	subscript (index : Int) -> [GLfloat] {mutating get}
}