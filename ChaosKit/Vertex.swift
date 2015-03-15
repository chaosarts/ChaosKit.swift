//
//  Vertex.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 13.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct Vertex {
	
	/// Contains the position of the vertex
	private var _position : vec3?
	
	/// Contains the color of the vertex
	private var _color : vec4?
	
	/// Contains the normal of the vertex
	private var _normal : vec3?
	
	/// Contains the texture coordinate of the vertex
	private var _texcoord : vec2?
	
	/// Contains the position of the vertex
	public var position : vec3 {
		get {if _position == nil {return []}; return _position!}
		set {_position = newValue}
	}
	
	/// Contains the color of the vertex
	public var color : vec4 {
		get {if _color == nil {return []}; return _color!}
		set {_color = newValue}
	}
	
	/// Contains the normal of the vertex
	public var normal : vec3 {
		get {if _normal == nil {return []}; return _normal!}
		set {_normal = newValue}
	}
	
	/// Contains the texture coordinate of the vertex
	public var texcoord : vec2 {
		get {if _texcoord == nil {return []}; return _texcoord!}
		set {_texcoord = newValue}
	}
	
	/// Subscript access to the properties by AttributeTarget enumeration
	subscript (index: AttributeTarget) -> ArrayRepresentable {
		get {
			switch index {
			case .Position: return position
			case .Color: return color
			case .Normal: return normal
			case .TexCoord: return texcoord
			}
		}
	}
	
	public init () {}
	
	/**
	Determines if the vertex attribute has acutally been set
	
	:param: target The attribute target to check
 	:returns: True when the according target has been properly set, otherwise false
	*/
	public func provides (target: AttributeTarget) -> Bool {
		switch target {
		case .Position: return _position != nil
		case .Color: return _color != nil
		case .Normal: return _normal != nil
		case .TexCoord: return _texcoord != nil
		default: return false
		}
	}
}