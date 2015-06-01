//
//  GImage.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLImage {
	
	private let _image : CGImage
	
	public var width : Int {get {return CGImageGetWidth(_image)}}
	
	public var height : Int {get {return CGImageGetHeight(_image)}}
	
	public var alphaInfo : CGImageAlphaInfo {get {return CGImageGetAlphaInfo(_image)}}
	
	public var bitmapInfo : CGBitmapInfo {get {return CGImageGetBitmapInfo(_image)}}
	
	public var bitsPerPixel : Int {get {return CGImageGetBitsPerPixel(_image)}}
	
	public var bitsPerComponent : Int {get {return CGImageGetBitsPerComponent(_image)}}
	
	public var bytesPerRow : Int {get {return CGImageGetBytesPerRow(_image)}}
	
	public var colorSpace : CGColorSpace {get {return CGImageGetColorSpace(_image)}}
	
	public var dataProvider : CGDataProvider {get {return CGImageGetDataProvider(_image)}}
	
	public init (_ image: CGImage) {
		_image = image
	}
	
	public convenience init (_ source: CGImageSource!, _ index: Int, _ options: CFDictionary!) {
		var image : CGImage = CGImageSourceCreateImageAtIndex(source, index, options)
		self.init(image)
	}
}