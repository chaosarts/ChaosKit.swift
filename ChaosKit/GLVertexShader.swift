//
//  GLVertexShader.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 22.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class GLVertexShader: GLShader {
	
	
	public convenience init? (source: String) {
		self.init(sources: [source])
	}
	
	
	public convenience init? (sources: [String]) {
		self.init(type: GLenum(GL_VERTEX_SHADER), sources: sources)
	}
	
	public convenience init? (resource: String, encoding: NSStringEncoding = NSUTF8StringEncoding) {
		self.init(resource: resource, encoding: encoding)
	}
	
	
	public convenience init? (resources: [String], encoding: NSStringEncoding = NSUTF8StringEncoding) {
		self.init(type: GLenum(GL_VERTEX_SHADER), resources: resources, encoding: encoding)
	}
	
	
	public convenience init? (file: String, encoding: NSStringEncoding = NSUTF8StringEncoding) {
		self.init(files: [file], encoding: encoding)
	}
	
	
	public convenience init? (files: [String], encoding: NSStringEncoding = NSUTF8StringEncoding) {
		self.init(type: GLenum(GL_VERTEX_SHADER), files: files, encoding: encoding)
	}
}
