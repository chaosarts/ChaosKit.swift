//
//  GLDisplayManager.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Central display object management
*/
internal class GLDisplayObjectManager {
	
	/// Singleton instance
	private static var instance : GLDisplayObjectManager?
	
	/// The current id counter to 'generate' id
	private var _id : Int
	
	/** 
	Singleton getter
	
	:return: The GLDisplayObjectManager singleton object
	*/
	class func getInstance () -> GLDisplayObjectManager {
		if instance == nil {
			instance = GLDisplayObjectManager()
		}
		
		return instance!
	}
	
	
	/**
	Initializes the manager
	*/
	private init () {
		_id = 0
	}
	
	
	/**
	Generates a new id
	
	:return: GLDisplayObjectId
	*/
	func generateId () -> GLDisplayObjectId {
		return GLDisplayObjectId(integerLiteral: _id++)
	}
}