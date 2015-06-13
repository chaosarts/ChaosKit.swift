//
//  Serializeable.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 12.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public protocol Exportable {
	var exportData : ExportData {get}
}

public protocol ExportFormat {
	func format (data: ExportData) -> String
}


public final class ExportData {
	
	public private(set) var value : Printable
	
	public private(set) var attributes : [String : String] = [String : String]()
	
	public internal(set) var parent : ExportData?
	
	public internal(set) var children : [ExportData] = []
	
	public var isLeaf : Bool {get {return children.count > 0}}
	
	public var isRoot : Bool {get {return parent != nil}}
	
	
	public init (_ value: Printable) {
		self.value = value
	}
}