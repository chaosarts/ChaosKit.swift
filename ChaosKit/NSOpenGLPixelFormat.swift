//
//  NSOpenGLPixelFormat.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 21.08.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public extension NSOpenGLPixelFormat {
	
	static let allAttributeKeys :[NSOpenGLPixelFormatAttribute] = [
		UInt32(NSOpenGLPFAAllRenderers),
		UInt32(NSOpenGLPFATripleBuffer),
		UInt32(NSOpenGLPFADoubleBuffer),
		UInt32(NSOpenGLPFAStereo),
		UInt32(NSOpenGLPFAAuxBuffers),
		UInt32(NSOpenGLPFAColorSize),
		UInt32(NSOpenGLPFAAlphaSize),
		UInt32(NSOpenGLPFADepthSize),
		UInt32(NSOpenGLPFAStencilSize),
		UInt32(NSOpenGLPFAAccumSize),
		UInt32(NSOpenGLPFAMinimumPolicy),
		UInt32(NSOpenGLPFAMaximumPolicy),
		UInt32(NSOpenGLPFASampleBuffers),
		UInt32(NSOpenGLPFASamples),
		UInt32(NSOpenGLPFAAuxDepthStencil),
		UInt32(NSOpenGLPFAColorFloat),
		UInt32(NSOpenGLPFAMultisample),
		UInt32(NSOpenGLPFASupersample),
		UInt32(NSOpenGLPFASampleAlpha),
		UInt32(NSOpenGLPFARendererID),
		UInt32(NSOpenGLPFANoRecovery),
		UInt32(NSOpenGLPFAAccelerated),
		UInt32(NSOpenGLPFAClosestPolicy),
		UInt32(NSOpenGLPFABackingStore),
		UInt32(NSOpenGLPFAScreenMask),
		UInt32(NSOpenGLPFAAllowOfflineRenderers),
		UInt32(NSOpenGLPFAAcceleratedCompute),
		UInt32(NSOpenGLPFAOpenGLProfile),
		UInt32(NSOpenGLPFAVirtualScreenCount)
	]
	
//	public convenience init? (attributes: [NSOpenGLPixelFormatAttribute]) {
//		let pointer : UnsafeMutablePointer<NSOpenGLPixelFormatAttribute> = UnsafeMutablePointer<NSOpenGLPixelFormatAttribute>(attributes)
//		self.init(attributes: pointer)
//	}
	
	public convenience init? (pixelFormat: NSOpenGLPixelFormat, attributeMap: [NSOpenGLPixelFormatAttribute : NSOpenGLPixelFormatAttribute]) {
		
		let valuePointer : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
		var attributes : [NSOpenGLPixelFormatAttribute] = []
		
		for attributeKey in NSOpenGLPixelFormat.allAttributeKeys {
			var attributeValue : NSOpenGLPixelFormatAttribute? = attributeMap[attributeKey]
			if nil == attributeValue {
				pixelFormat.getValues(valuePointer, forAttribute: attributeKey, forVirtualScreen: 0)
				print("\(attributeKey): \(valuePointer.memory)")
				attributeValue = NSOpenGLPixelFormatAttribute(valuePointer.memory)
			}
			
			attributes.appendContentsOf([attributeKey, attributeValue!])
		}
		
		valuePointer.dealloc(1)
		valuePointer.destroy()
		
		let pointer : UnsafeMutablePointer<NSOpenGLPixelFormatAttribute> = UnsafeMutablePointer<NSOpenGLPixelFormatAttribute>(attributes)
		self.init(attributes: pointer)
	}
}