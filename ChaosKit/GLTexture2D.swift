//
//  GLTexture2D.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/// Class for OpenGL 2D textures
public class GLTexture2D : GLTextureBase, GLTexture {
	
	/// Provides the width of the texture
	private var _width : GLsizei
	
	/// Provides the height of the texture
	private var _height : GLsizei
	
	/// Provides the width of the texture
	public var width : GLsizei {get {return _width}}
	
	/// Provides the width of the texture
	public var height : GLsizei {get {return _height}}
	
	
	/**
	Initializes the texture purely with width, height and pixels as array of floats
	
	:param: width The width of the texture
	:param: height The height of the texture
	:param: pixels The pixels as serialized rgb-float values
	*/
	public init (width: Int, height: Int, pixels: UnsafeMutablePointer<Void>) {
		_width = GLsizei(width)
		_height = GLsizei(height)
		super.init(GLenum(GL_TEXTURE_2D), pixels: pixels)
	}
	
	
	/**
	Initializes the texutres with passed path to an image file
	
	:param: imagefile The path to the image file
	*/
	public convenience init (imagefile: String!, baseurl: CFURL? = nil, options: CFDictionary? = nil) {
		var source : CGImageSource = CGImageSourceCreateWithString(imagefile, baseurl, options)
		var image : GLImage = GLImage(source, 0, nil)
		var ptr : UnsafeMutablePointer<Void> = calloc(image.width * image.height, image.bitsPerPixel)
		self.init(width: image.width, height: image.height, pixels: ptr)
	}
	
	
	public convenience init? (imageResource: String!) {
		var bundle : NSBundle = NSBundle.mainBundle()
		var filename : String? = bundle.pathForImageResource(imageResource)
		
		self.init(imagefile: filename)
		
		if filename == nil {return nil}
	}
	
	
	/** 
	Initializes the texture
	
	:param: resource A path to a resource as string
	:param: ofType The type of the resource
	:param: inDirectory The directory within the resource base path
	*/
	public convenience init? (resource: String, ofType: String? = nil, inDirectory: String? = nil) {
		var bundle : NSBundle = NSBundle.mainBundle()
		var filename : String? = bundle.pathForResource(resource, ofType: ofType, inDirectory: inDirectory)
		
		self.init(imagefile: filename!)
		
		if filename == nil {return nil}
	}
	
	
	/**
	Specifies the wrap s function
	
	:param: value
	*/
	public func setWrapS (value: Int32) {
		setParameteri(GLenum(GL_TEXTURE_WRAP_S), value)
	}
	
	
	/**
	Specifies the wrap t function
	
	:param: value
	*/
	public func setWrapT (value: Int32) {
		setParameteri(GLenum(GL_TEXTURE_WRAP_T), value)
	}
}