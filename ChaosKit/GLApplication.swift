//
//  GLApplication.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
*/
//@objc
//public final class GLApplicationSaveState {
//	
//	private var bools : [String : Bool] = [String : Bool]()
//	
//	private var integers : [String : Int] = [String : Int] ()
//	
//	private var floats : [String : Float] = [String : Float]()
//	
//	private var doubles : [String : Double] = [String : Double]()
//	
//	private var strings : [String : String] = [String : String]()
//	
//	
//	public func set (key: String!, bool: Bool) {
//		bools[key] = bool
//	}
//	
//	public func set (key: String!, int: Int) {
//		integers[key] = int
//	}
//	
//	public func set (key: String!, float: Float) {
//		floats[key] = float
//	}
//	
//	public func set (key: String!, double: Double) {
//		doubles[key] = double
//	}
//	
//	public func set (key: String!, string: String) {
//		strings[key] = string
//	}
//	
//	
//	public func getBool (key: String) -> Bool? {
//		return bools[key]
//	}
//	
//	
//	public func getInt (key: String) -> Int? {
//		return integers[key]
//	}
//	
//	
//	public func getFloat (key: String) -> Float? {
//		return floats[key]
//	}
//	
//	
//	public func getDouble (key: String) -> Double? {
//		return doubles[key]
//	}
//	
//	
//	public func getString (key: String) -> String? {
//		return strings[key]
//	}
//}
public struct GLAppConfig {
	
}

@objc
public protocol GLAppDelegate {
	
	optional func onInit ()
	
	optional func onResume ()
	
	optional func onStart ()
	
	optional func onPause ()
	
	optional func onStop ()
}


public class GLApplication {
	
	internal var delegate : GLAppDelegate?
	
	
	public init (config: GLAppConfig? = nil) {}
	
	func run () {
		delegate?.onInit?()
		delegate?.onStart?()
	}
	
	
	func pause () {
		delegate?.onPause?()
	}
	
	
	func saveState () {
		
	}
	
	
	func restoreState () {
		
	}
}