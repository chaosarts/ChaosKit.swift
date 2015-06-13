//
//  ArrayRepresentable.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol ArrayRepresentable {
	var array : [GLfloat] {get}
}


public protocol ListType : ArrayRepresentable {
	static var elementCount : Int {get}
}