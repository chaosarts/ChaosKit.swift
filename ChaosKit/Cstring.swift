//
//  CString.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 27.08.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct Cstring : Printable {
	
	///
	public private(set) var chars : [CChar]
	
	public var ptr : UnsafePointer<CChar> {
		get {return UnsafePointer(chars)}
	}
	
	public var description : String {
		get {
			let string : String? = String.fromCString(ptr)
			if nil == string {return ""}
			return string!
		}
	}
	
	public var isNullTerminated : Bool {get {return chars.last == 0}}
	
	public var count : Int {get {return isNullTerminated ? chars.count - 1 : chars.count}}
	
	public init (_ characters: [CChar]) {
		self.chars = characters
	}
	
	
	public init? (string: String, encoding: NSStringEncoding) {
		let chars : [CChar]? = string.cStringUsingEncoding(encoding)
		if nil == chars {return nil}
		self.init(chars!)
	}
	
	
	public init? (string: String) {
		self.init(string: string, encoding: NSUTF8StringEncoding)
	}
}