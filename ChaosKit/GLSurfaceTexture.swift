//
//  GLTextureMap.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 25.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol GLTextureMap : GLAttribute {
	var texture : GLTexture {get}
}