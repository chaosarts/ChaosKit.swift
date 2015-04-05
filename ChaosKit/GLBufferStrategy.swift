//
//  GLBufferStrategy.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 04.04.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLBufferStrategy {
	func buffer (vertice: [GLVertex])
}


//public class GLDefaultBufferStrategy : GLBufferStrategy {
//	
//	public var useTexcoord : Bool = true
//	
//	public func buffer(vertice: [GLVertex]) {
//		if vertice.count == 0 {return}
//		
//		var vertexQueue : CKQueue<GLVertex> = CKQueue<GLVertex>(vertice)
//		var vertex : GLVertex? = vertexQueue.dequeue()
//		
//		var pointer : UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(1)
//		glGenBuffers(1, pointer)
//		
//		var info : GLBufferInformation = GLBufferInformation()
//		info.addBlock(GLBufferBlock(pointer, .Position, vertex!.position.array.count))
//		info.addBlock(GLBufferBlock(pointer, .Normal, vertex!.normal.array.count))
//		info.addBlock(GLBufferBlock(pointer, .Color, vertex!.color.array.count))
//		if useTexcoord {info.addBlock(GLBufferBlock(pointer, .TexCoord, vertex!.texcoord.array.count))}
//		
//		var data : [GLfloat] = []
//		
//		while (vertex != nil) {
//			data += vertex!.position.array
//			data += vertex!.normal.array
//			data += vertex!.color.array
//			if useTexcoord {data += vertex!.texcoord.array}
//			vertex = vertexQueue.dequeue()
//		}
//	}
//}