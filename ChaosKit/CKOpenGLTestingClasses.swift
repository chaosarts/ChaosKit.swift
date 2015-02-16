//
//  CKOpenGLTestingClasses.swift
//  ChaosKit
//
//  Created by Netzbewegung User on 16.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa




public struct CKVertex {
    private var _attributes : [CKOpenGLVertexAttributeType : CKOpenGLVertexAttribute] =
    [CKOpenGLVertexAttributeType : CKOpenGLVertexAttribute]()
    
    public var position : CKOpenGLVertexAttribute {
        get {return _attributes[CKOpenGLVertexAttributeType.Position]!}
        set {
            assert(newValue.data.count == 0, "Vertex attribute position must not be empty.")
            _attributes[CKOpenGLVertexAttributeType.Position] = newValue
        }
    }
    
    public var color : CKOpenGLVertexAttribute? {
        get {return _attributes[CKOpenGLVertexAttributeType.Color]}
        set {
            if nil != newValue || newValue!.data.count == 0 {
                _attributes.removeValueForKey(CKOpenGLVertexAttributeType.Color)
            }
            _attributes[CKOpenGLVertexAttributeType.Color] = newValue
        }
    }
    
    public var normal : CKOpenGLVertexAttribute? {
        get {return _attributes[CKOpenGLVertexAttributeType.Normal]}
        set {_attributes[CKOpenGLVertexAttributeType.Normal] = newValue}
    }
    
    public var texcoord : CKOpenGLVertexAttribute? {
        get {return _attributes[CKOpenGLVertexAttributeType.TexCoord]}
        set {_attributes[CKOpenGLVertexAttributeType.TexCoord] = newValue}
    }
    
    
    public init (position: [GLfloat], color: [GLfloat] = [], normal: [GLfloat] = [], texcoord: [GLfloat] = []) {
        self.position = CKOpenGLVertexAttribute(data: position)
    }
}


public struct CKOpenGLVertexAttribute {
    public var data : [GLfloat]
    
    public init (data: [GLfloat]) {
        self.data = data
    }
}


public struct CKOpenGLAttributeVariable {
    
    public var locations : [GLint] = []
    
    public var name : String
    
    public var datatype : GLenum?
    
    public var size : GLint?
    
    public var location : GLint {
        get {return locations.count == 0 ? -1 : locations[0]}
    }
    
    
    public init (name: String) {
        self.name = name
    }
}


public enum CKOpenGLVertexAttributeType {
    case Position
    case Color
    case Normal
    case TexCoord
}