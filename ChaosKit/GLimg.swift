//
//  GImage.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public class GLimage {
	
	/// The native image object
	private let _image : CGImage
	
	/// Return the width of `image'.
	public var width : Int {get {return CGImageGetWidth(_image)}}
	
	/// Return the height of `image'.
	public var height : Int {get {return CGImageGetHeight(_image)}}
	
	/// Return the alpha info of `image'.
	public var alphaInfo : CGImageAlphaInfo {get {return CGImageGetAlphaInfo(_image)}}
	
	/// Return the bitmap info of `image'.
	public var bitmapInfo : CGBitmapInfo {get {return CGImageGetBitmapInfo(_image)}}
	
	/// Return the bits per pixel of `image'.
	public var bitsPerPixel : Int {get {return CGImageGetBitsPerPixel(_image)}}
	
	///  Return the bits per component of an pixel of `image'.
	public var bitsPerComponent : Int {get {return CGImageGetBitsPerComponent(_image)}}
	
	/// Returns the bytes per row
	public var bytesPerRow : Int {get {return CGImageGetBytesPerRow(_image)}}
	
	/// Returns the color space
	public var colorSpace : CGColorSpace {get {return CGImageGetColorSpace(_image)}}
	
	/// Returns the data provider
	public var dataProvider : CGDataProvider {get {return CGImageGetDataProvider(_image)}}
	
	
	/// Initalizes the image
	internal init (_ image: CGImage) {
		_image = image
	}
}