//
//  debug.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public func log (message: String, _ type: CKLogType = .Info) {
	let date : NSDate = NSDate()
	let calendar : NSCalendar = NSCalendar.currentCalendar()
	let components : NSDateComponents = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
	let m : String = "\(components.hour):\(components.minute):\(components.second)"
		+ " [\(type.rawValue)]: \(message)"
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
