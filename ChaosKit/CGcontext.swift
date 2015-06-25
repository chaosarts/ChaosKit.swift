//
//  CGcontext.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 25.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct CGbmpctx {
	
	public let ref : CoreGraphics.CGContext
	
	public private(set) var data : UnsafeMutablePointer<Void>
	
	
	public init (_ data: UnsafeMutablePointer<Void>, _ width: Int, _ height: Int, _ bitsPerComponent: Int,
		_ bytesPerRow: Int, _ space: CGColorSpace?, _ bitmapInfo: CGBitmapInfo) {
		self.ref = CGBitmapContextCreate(data, width, height, bitsPerComponent, bytesPerRow, space, bitmapInfo)
		self.data = data
	}
	
	
	public init (_ width: Int, _ height: Int, _ bitsPerComponent: Int, _ bytesPerRow: Int,
		_ space: CGColorSpace?, _ bitmapInfo: CGBitmapInfo) {
		self.init(malloc(height * bytesPerRow), width, height, bitsPerComponent, bytesPerRow, space, bitmapInfo)
	}
	
	
	public init (_ image: CGimage) {
		self.init(image.width, image.height, image.bitsPerComponent, image.bytesPerRow, image.colorSpace, image.bitmapInfo)
	}
	
	
	public func draw (image: CGimage) {
		self.draw(image, rect: CGRect(x: 0, y: 0, width: image.width, height: image.height))
	}
	
	
	public func draw (image: CGimage, rect: CGRect) {
		self.draw(image.ref, rect: rect)
	}
	
	
	public func draw (image: CGImageRef, rect: CGRect) {
		CGContextDrawImage(ref, rect, image)
	}
}