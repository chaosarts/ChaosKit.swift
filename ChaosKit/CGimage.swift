//
//  GImage.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct CGimage {
	
	/// The native image object
	public let ref : CGImageRef
	
	/// Return the width of `image'.
	public var width : Int {get {return CGImageGetWidth(ref)}}
	
	/// Return the height of `image'.
	public var height : Int {get {return CGImageGetHeight(ref)}}
	
	/// Return the alpha info of `image'.
	public var alphaInfo : CGImageAlphaInfo {get {return CGImageGetAlphaInfo(ref)}}
	
	/// Return the bitmap info of `image'.
	public var bitmapInfo : CGBitmapInfo {get {return CGImageGetBitmapInfo(ref)}}
	
	/// Return the bits per pixel of `image'.
	public var bitsPerPixel : Int {get {return CGImageGetBitsPerPixel(ref)}}
	
	///  Return the bits per component of an pixel of `image'.
	public var bitsPerComponent : Int {get {return CGImageGetBitsPerComponent(ref)}}
	
	/// Returns the bytes per row
	public var bytesPerRow : Int {get {return CGImageGetBytesPerRow(ref)}}
	
	/// Returns the color space
	public var colorSpace : CGColorSpace {get {return CGImageGetColorSpace(ref)}}
	
	/// Returns the data provider
	public var dataProvider : CGDataProvider {get {return CGImageGetDataProvider(ref)}}
	
	
	/// Initalizes the image
	public init (_ image: CGImageRef) {
		ref = image
	}
	
	
	public init (_ width: Int, _ height: Int, _ bitsPerComponent: Int, _ bitsPerPixel: Int, _ bytesPerRow: Int,
		_ space: CGColorSpace!, _ bitmapInfo: CGBitmapInfo, _ provider: CGDataProvider!,
		_ decode: UnsafePointer<CGFloat>, _ shouldInterpolate: Bool, _ intent: CGColorRenderingIntent) {
		self.init(CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, space, bitmapInfo, provider, decode, shouldInterpolate, intent))
	}
}