//
//  GLsrcfile.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 18.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct GLsrcfile : StringLiteralConvertible, Printable {
	
	/// Provides the source code of the shader
	public private(set) var content : String
	
	/// Provides the encoding of the source
	public var encoding : NSStringEncoding = NSUTF8StringEncoding
	
	/// Provides the description of the source
	public var description : String {get {return content}}
	
	/// Provides the length of the source string as chars
	public var length : Int! {get {return count(content)}}
	
	/// Provides the cstring version of the source
	public var cstring : Cstring? {get {return Cstring(string: content, encoding: encoding)}}
	
	
	/**
	Initializes the source with given string
	
	:param: src The source as string
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
	
	:param: path The source path to read
	:param: encoding The encoding to use for reading the path
	:param: pointer A pointer for errors
	*/
	public init? (path: String, encoding: NSStringEncoding, pointer: NSErrorPointer) {
		let content : String? = String(contentsOfFile: path, encoding: encoding, error: pointer)
		if nil == content {return nil}
		self.init(content: content!)
	}
	
	
	/**
	Initializes the source with given path
	
	:param: path The source path to read
	:param: encoding The encoding to use for reading the path
	*/
	public init? (path: String, encoding: NSStringEncoding) {
		self.init(path: path, encoding: encoding, pointer: nil)
	}
	
	
	/**
	Initializes the source with given path
	
	:param: path The source path to read
	*/
	public init? (path: String) {
		self.init(path: path, encoding: NSUTF8StringEncoding, pointer: nil)
	}
	
	
	/**
	Initializes the source with given resource
	
	:param: resource The resource path to read
	:param: encoding The encoding to use for reading the path
	:param: pointer A pointer for errors
	*/
	public init? (resource: String, encoding: NSStringEncoding, pointer: NSErrorPointer) {
		let path : String? = NSBundle.mainBundle().pathForResource(resource, ofType: nil)
		if nil == path {return nil}
		self.init (path: path!, encoding: encoding, pointer: pointer)
	}
	
	
	/**
	Initializes the source with given resource
	
	:param: resource The resource path to read
	:param: encoding The encoding to use for reading the path
	*/
	public init? (resource: String, encoding: NSStringEncoding) {
		self.init(resource: resource, encoding: encoding, pointer: nil)
	}
	
	
	/**
	Initializes the source with given resource
	
	:param: resource The resource path to read
	*/
	public init? (resource: String) {
		self.init(resource: resource, encoding: NSUTF8StringEncoding, pointer: nil)
	}
	
	
	/**
	Initializer to assign string literals to a shader source object
	
	:param: stringLiteral The source as string
	*/
	public init (stringLiteral value: String) {
		self.init(content: value)
	}
	
	
	/**
	Initializer to assign string literals to a shader source object
	
	:param: stringLiteral The source as string
	*/
	public init(extendedGraphemeClusterLiteral value: String) {
		self.init(content: value)
	}
	
	
	/**
	Initializer to assign string literals to a shader source object
	
	:param: stringLiteral The source as string
	*/
	public init(unicodeScalarLiteral value: String) {
		self.init(content: value)
	}
}