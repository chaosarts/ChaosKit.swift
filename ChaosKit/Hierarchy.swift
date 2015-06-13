//
//  Struct.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol Hierarchy {
	
	var parent : Self? {get}
	
	var children : [Self] {get}
}