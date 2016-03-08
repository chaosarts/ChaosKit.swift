//
//  GLsrcfile.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 18.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct GLsrcfile : StringLiteralConvertible, CustomStringConvertible {
	
	/// Provides the source code of the shader
	public private(set) var content : String
	
	/// Provides the encoding of the source
	public var encoding : NSStringEncoding = NSUTF8StringEncoding
	
	/// Provides the description of the source
	public var description : String {get {return content}}
	
	/// Provides the length of the source string as chars
	public var length : Int! {get {return content.characters.count}}
	
	/// Provides the cstring version of the source
	public var cstring : Cstring? {get {return Cstring(string: content, encoding: encoding)}}
	
	
	/**
	Initializes the source with given string
	
	- parameter src: The source as string
	*/
	public init (content: String) {
		self.content = content
	}
	
	
	/**
	Initializes an empty source
	*/
	public init () {
		self.init(content: "")
	}
	
	
	/**
	Initializes the source with given path
	
	- parameter path: The source path to read
	- parameter encoding: The encoding to use for reading the path
	- parameter pointer: A pointer for errors
	*/
	public init (path: String, encoding: NSStringEncoding) throws {
		var pointer: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
		let content : String?
		do {
			content = try String(contentsOfFile: path, encoding: encoding)
		} catch let error as NSError {
			pointer = error
			content = nil
		}
		if nil == content {throw pointer}
		self.init(content: content!)
	}
	
	
	/**
	Initializes the source with given path
	
	- parameter path: The source path to read
	*/
	public init (path: String) throws {
		try self.init(path: path, encoding: NSUTF8StringEncoding)
	}
	
	
	/**
	Initializes the source with given resource
	
	- parameter resource: The resource path to read
	- parameter encoding: The encoding to use for reading the path
	- parameter pointer: A pointer for errors
	*/
	public init (resource: String, encoding: NSStringEncoding) throws {
		let pointer: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
		let path : String? = NSBundle.mainBundle().pathForResource(resource, ofType: nil)
		if nil == path {throw pointer}
		try self.init (path: path!, encoding: encoding)
	}
	
	/**
	Initializes the source with given resource
	
	- parameter resource: The resource path to read
	*/
	public init? (resource: String) {
		try? self.init(resource: resource, encoding: NSUTF8StringEncoding)
	}
	
	
	/**
	Initializer to assign string literals to a shader source object
	
	- parameter stringLiteral: The source as string
	*/
	public init (stringLiteral value: String) {
		self.init(content: value)
	}
	
	
	/**
	Initializer to assign string literals to a shader source object
	
	- parameter stringLiteral: The source as string
	*/
	public init(extendedGraphemeClusterLiteral value: String) {
		self.init(content: value)
	}
	
	
	/**
	Initializer to assign string literals to a shader source object
	
	- parameter stringLiteral: The source as string
	*/
	public init(unicodeScalarLiteral value: String) {
		self.init(content: value)
	}
}