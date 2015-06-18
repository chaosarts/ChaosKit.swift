//
//  File.swift
//  Computergrafik
//
//  Created by Fu Lam Diep on 16.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import ChaosKit

public class GLParallelogram : GLGeometry {
	
	/// Caches the points
	private var _cache : [vec3]?
	
	/// Returns the counts of vertice
	public var count : Int {get {return values.count}}
	
	/// Provides the size per vertex
	public var size : Int {get {return 3}}
	
	/// Indicates, whether vertice are dynamic or not
	public var dynamic : Bool = false
	
	/// Indicates whether vertices are shared or not
	public var indexed : Bool = false {didSet{_cache = nil}}
	
	/// Provides the list of indices
	public private(set) var indexlist : [Int]?
	
	/// Provides a list of vertice
	public var values : [vec3] {get {updateCache(); return _cache!}}
	
	/// Provides the first vector that clamps the ractangle
	public var u : vec3 {didSet{_cache = nil}}
	
	/// Provides the second vector that clamps the ractangle
	public var v : vec3 {didSet{_cache = nil}}
	
	//// Provides the origin of the rectangle
	public var origin : vec3 {didSet{_cache = nil}}
	
	/// Provides the normal of the rectangle
	public var normal : vec3 {get {return cross(u, v)}}
	
	/// 
	public var normals : GLShapeProperty? {get {return GLGeometrySingleNormal3D(value: normal)}}
	
	/// Provides the width of the rectangle
	public var width : GLfloat {get {return u.magnitude}}
	
	/// Provides the height of the rectangle
	public var height : GLfloat {get {return v.magnitude}}
	
	/// Subscript access to one vertex as float list
	public subscript (index: Int) -> [GLfloat] {
		get {return values[index].array}
	}
	
	
	/** 
	Initializes the rectangle with passed origin and the two 
	clamp vector u and v
	
	:param: origin The origin of the rectangle
	:param: u
	:param: v
	*/
	public init (origin o: vec3, u: vec3, v: vec3) {
		self.origin = o
		self.u = u
		self.v = v
	}
	
	
	/**
	Initializes the rectangle with passed origin and the two
	clamp vector u and v
	
	:param: center The origin of the rectangle
	:param: u
	:param: v
	*/
	public convenience init (center c: vec3, u: vec3, v: vec3) {
		self.init(origin: c - 0.5 * (u + v), u: u, v: v)
	}
	
	
	/**
	Initializes the rectangle with passed origin and the two
	clamp vector u and v
	
	:param: center The origin of the rectangle
	:param: u
	:param: v
	*/
	public convenience init (u: vec3, v: vec3) {
		self.init(origin: vec3(), u: u, v: v)
	}
	
	
	/**
	Updates the internal vertice cache
 	*/
	public func updateCache () {
		if nil != _cache {return}		
		_cache = GLParallelogram.generateValues(origin, u: u, v: v)
	}
}


extension GLParallelogram {
	public class func generateValues (origin: vec3, u: vec3, v: vec3) -> [vec3]{
		let a : vec3 = origin
		let b : vec3 = origin + u
		let c : vec3 = origin + u + v
		let d : vec3 = origin + v
		return [a, b, c, c, d, a]
	}
}