//
//  Texture.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 15.03.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import OpenGL

public class GLTexture : GLBase {
	
	public let target : GLenum
	
	public init (target: Int32) {
		var textures : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
		glGenTextures(1, textures)
		
		self.target = GLenum(target)
		super.init(id: textures.memory)
	}
	
	
	public func bind () {
		glBindTexture(target, id)
	}
	
	
	public func unbind() {
		glBindTexture(target, 0)
	}
	
	
	private func iv (pname: Int32) -> GLint {
		if _ivCache[pname] == nil {updateIvCache(pnames: pname)}
		return _ivCache[pname]!
	}
	
	
	private func updateIvCache (pnames names: Int32...) {
		for pname in names {
			var params : UnsafeMutablePointer<GLint> = UnsafeMutablePointer<GLint>.alloc(1)
			glGetTexParameteriv(target, GLenum(pname), params)
			_ivCache[pname] = params.memory
		}
	}
}