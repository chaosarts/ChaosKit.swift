//
//  image.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.05.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

func toCGImage (image: NSImage) -> CGImage? {
	let data : NSData? = image.TIFFRepresentation
	if data == nil {return nil}
	
	let source : CGImageSourceRef! = CGImageSourceCreateWithData(data! as CFDataRef, nil)
	let imageRef : CGImage = CGImageSourceCreateImageAtIndex(source, Int(0), nil)
	return imageRef
}


func CGImageSourceCreateWithCFString (urlString: CFString!, baseUrl: CFURL!, options: CFDictionary!) -> CGImageSource {
	var url : CFURL = CFURLCreateWithString(nil, urlString, baseUrl)
	return CGImageSourceCreateWithURL(url, options)
}


func CGImageSourceCreateWithString (urlString: String!, baseUrl: CFURL!, options: CFDictionary!) -> CGImageSource {
	var cfString : CFString = NSString(string: urlString)
	return CGImageSourceCreateWithCFString(cfString, baseUrl, options)
}