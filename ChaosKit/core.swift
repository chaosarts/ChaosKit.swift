//
//  core.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 21.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

prefix operator * {}

public enum CKLogType : String {
	case Info = "Info"
	case Warning = "Warning"
	case Error = "Error"
}


public func log (message: String, type: CKLogType) {
	let date : NSDate = NSDate()
	let calendar : NSCalendar = NSCalendar.currentCalendar()
	let components : NSDateComponents = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
	let m : String = message + "\(components.hour):\(components.minute):\(components.second)"
		+ " [\(type.rawValue)]: \(message) (in \(__FILE__), line \(__LINE__))"
	println(m)
}


public func info (message: String) {
	log(message, .Info)
}


public func warn (message: String) {
	log(message, .Warning)
}


public func error (message: String) {
	log(message, .Error)
}


public prefix func *<T>(ptr : UnsafePointer<T>) -> T{
	return ptr.memory
}


public prefix func *<T>(ptr : UnsafeMutablePointer<T>) -> T{
	return ptr.memory
}


public func *<T: UnsignedIntegerType>(l: String, r: T) -> String {
	var output = l
	var count : T = 0
	
	while count < r {
		output = output + l
		count++
	}
	
	return output
}


public func *<T: UnsignedIntegerType>(l: T, r: String) -> String {
	return r * l
}


public func *(l: String, r: Int) -> String {
	return l * UInt32(r)
}


public func *(l: Int, r: String) -> String {
	return UInt32(l) * r
}