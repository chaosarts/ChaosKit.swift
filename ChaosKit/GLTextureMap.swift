//
//  GLTextureMap.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
*/
public protocol GLTextureMap : GLBufferable {
	var texture : GLTexture {get}
}