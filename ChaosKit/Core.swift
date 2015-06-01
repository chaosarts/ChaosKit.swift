//
//  core.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 21.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

prefix operator * {}

/**
Cases to indicate how to fetch an attribute value for an index, which is not
between 0 and the the count of vertices in an vertex attribute object
*/
public enum CKIndexWrapType {	
	
	/// Indicates to use modulo
	case Repeat
	
	/// Indicates alternate modulo
	case Mirrored
	
	/// 
	case Restrict
}

typealias CKIndexWrapper = (val: Int, minVal: Int, maxVal: Int) -> Int

func repeatIndex (val: Int, minVal: Int, maxVal: Int) -> Int {
	var minimum : Int = min(minVal, maxVal)
	var maximum : Int = max(minVal, maxVal)
	var distance : Int = abs(maximum - minimum)
	return (val - minimum) % distance + minimum
}

public enum CKLogType : String {
	case Info = "Info"
	case Warning = "Warning"
	case Error = "Error"
}
