//
//  CKOpenGLGeometryShader.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import OpenGL

public class CKOpenGLGeometryShader: CKOpenGLShader {
	public convenience init?(source: String) {
		self.init(sources: [source])
	}
	
	
	public init? (sources: [String]) {
		super.init(type: GLenum(GL_GEOMETRY_SHADER), sources: sources)
	}
	
	
	public convenience init? (file: String, encoding: NSStringEncoding) {
		self.init(files: [file], encoding: encoding)
	}
	
	
	public init? (files: [String], encoding: NSStringEncoding) {
		super.init(type: GLenum(GL_GEOMETRY_SHADER), files: files, encoding: encoding)
	}
}
