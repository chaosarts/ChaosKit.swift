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
	private let _reference : CGImageRef
	
	/// The CGImage object
	public var reference : CGImageRef {get {return _reference}}
	
	/// Return the width of `image'.
	public var width : Int {get {return CGImageGetWidth(_reference)}}
	
	/// Return the height of `image'.
	public var height : Int {get {return CGImageGetHeight(_reference)}}
	
	/// Return the alpha info of `image'.
	public var alphaInfo : CGImageAlphaInfo {get {return CGImageGetAlphaInfo(_reference)}}
	
	/// Return the bitmap info of `image'.
	public var bitmapInfo : CGBitmapInfo {get {return CGImageGetBitmapInfo(_reference)}}
	
	/// Return the bits per pixel of `image'.
	public var bitsPerPixel : Int {get {return CGImageGetBitsPerPixel(_reference)}}
	
	///  Return the bits per component of an pixel of `image'.
	public var bitsPerComponent : Int {get {return CGImageGetBitsPerComponent(_reference)}}
	
	/// Returns the bytes per row
	public var bytesPerRow : Int {get {return CGImageGetBytesPerRow(_reference)}}
	
	/// Returns the color space
	public var colorSpace : CGColorSpace {get {return CGImageGetColorSpace(_reference)}}
	
	/// Returns the data provider
	public var dataProvider : CGDataProvider {get {return CGImageGetDataProvider(_reference)}}
	
	
	/// Initalizes the image
	internal init (_ image: CGImageRef) {
		_reference = image
	}
}