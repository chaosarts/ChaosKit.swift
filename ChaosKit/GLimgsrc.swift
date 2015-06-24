//
//  GLImageSource.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/// CGImageSource wrapper class
public struct GLimgsrc {
	
	/// Returns the unique type identifier of an image source opaque type
	public static var typeId : CFTypeID {get {return CGImageSourceGetTypeID()}}
	
	/// Provides the native image source ref
	private var _reference : CGImageSourceRef
	
	/// Provides the native image source ref
	public var reference : CGImageSourceRef {get {return _reference}}
	
	/// Returns the uniform type identifier of the source container.
	public var type : CFString {get {return CGImageSourceGetType(reference)}}
	
	/// Returns the number of images (not including thumbnails) in the image source.
	public var count : Int {get {return CGImageSourceGetCount(reference)}}
	
	/// Return the status of an image source.
	public var status : CGImageSourceStatus {get {return CGImageSourceGetStatus(reference)}}
	
	
	/**
	Initializes the source 
	
	:param: src
	*/
	public init (_ src: CGImageSourceRef) {
		_reference = src
	}
	
	
	/** Initializes the source */
	public init (_ provider: CGDataProviderRef, _ options: CFDictionaryRef!) {
		self.init(CGImageSourceCreateWithDataProvider(provider, options));
	}
	
	
	/** Initializes the source */
	public init (_ data: CFDataRef!, _ options: CFDictionaryRef!) {
		self.init(CGImageSourceCreateWithData(data, options))
	}
	
	
	/** Initializes the source */
	public init (_ url: CFURL!, _ options: CFDictionaryRef!) {
		self.init(CGImageSourceCreateWithURL(url, options))
	}
	
	
	/** Initializes the source */
	public init (_ image: NSImage, _ options: CFDictionaryRef!) {
		self.init(image.TIFFRepresentation, options)
	}
	
	
	/** Initializes the source */
	public init? (filepath: String, options: CFDictionaryRef!) {
		var image : NSImage? = NSImage(contentsOfFile: filepath)
		if image == nil {return nil}
		self.init(image!, options)
	}
	
	
	/** Initializes the source */
	public init? (resource: String, options: CFDictionaryRef!) {
		var bundle : NSBundle = NSBundle.mainBundle()
		var image : NSImage? = bundle.imageForResource(resource)
		if image == nil {return nil}
		self.init(image!, options)
	}
	
	
	/** Initializes the source */
	public init? (url: NSURL, options: CFDictionaryRef!) {
		var image : NSImage? = NSImage(contentsOfURL: url)
		if image == nil {return nil}
		self.init(image!, options)
	}
	
	
	/// Creates an image from index
	public func createImage (index: Int, _ options: CFDictionaryRef!) -> GLimage {
		return GLimage(CGImageSourceCreateImageAtIndex(reference, index, options))
	}
	
	
	/// Creates a thumbnail
	public func createThumbnail (index: Int, _ options: CFDictionaryRef!) -> GLimage {
		return GLimage(CGImageSourceCreateThumbnailAtIndex(reference, index, options))
	}
}