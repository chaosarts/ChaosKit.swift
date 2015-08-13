//
//  GLAttributeContainer.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 06.08.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLAttributeContainer {
	/// Returns the sub attribute containers
	var attributeContainers : [GLAttributeContainer] {get}
	
	/// Provides a map of attribute objects
	var attributes : [GLurl : GLAttribute] {get}
}