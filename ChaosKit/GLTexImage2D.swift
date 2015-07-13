//
//  GLTexImage2D.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

/// Class for OpenGL 2D textures
public class GLTexImage2D : GLTexture {
	
	public var width : Int = 0
	
	public var height : Int = 0
	
	public init () {
		super.init(GLenum(GL_TEXTURE_2D))
	}
	
	
	public func setPixels (pixels: UnsafeMutablePointer<Void>, width: Int, height: Int, format: GLenum, type: GLenum) {
		self.width = width
		self.height = height
		glTexImage2D(target, level, internalFormat, GLsizei(width), GLsizei(height), 0, format, type, pixels)
	}
	
	
	public func useImage (image: CGImage) {
		var width : Int = CGImageGetWidth(image)
		var height : Int = CGImageGetHeight(image)
		var bitmap : NSBitmapImageRep = NSBitmapImageRep(CGImage: image)
		
		setPixels(bitmap.bitmapData, width: width, height: height, format: format, type: type)
	}
	
	
	public func loadFromSourceRef (source: CGImageSourceRef) {
		useImage(CGImageSourceCreateImageAtIndex(source, 0, nil))
	}
	
	
	public func loadFromUrl (url: CFURL!) {
		loadFromSourceRef(CGImageSourceCreateWithURL(url, nil))
	}
	
	
	public func loadFromFilepath (filepath: String!) {
		var url : NSURL? = NSURL.fileURLWithPath(filepath)
		loadFromUrl(url)
	}
	
	
	public func loadFromResource (resource: String, ofType type: String?) {
		var path : String? = NSBundle.mainBundle().pathForResource(resource, ofType: type)
		loadFromFilepath(path)
	}
}