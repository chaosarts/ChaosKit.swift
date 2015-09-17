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
public enum IndexWrapType {	
	
	/// Indicates to use modulo
	case Repeat
	
	/// Indicates alternate modulo
	case Mirrored
	
	/// 
	case Restrict
}

typealias IndexWrapper = (val: Int, minVal: Int, maxVal: Int) -> Int

func repeatIndex (val: Int, minVal: Int, maxVal: Int) -> Int {
	let minimum : Int = min(minVal, maxVal)
	let maximum : Int = max(minVal, maxVal)
	let distance : Int = abs(maximum - minimum)
	return (val - minimum) % distance + minimum
}

public enum LogType : String {
	case Info = "Info"
	case Warning = "Warning"
	case Error = "Error"
}
