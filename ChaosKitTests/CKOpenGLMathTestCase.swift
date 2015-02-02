//
//  CKOpenGLMathTestCase.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 26.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa
import ChaosKit
import XCTest

class CKOpenGLMathTestCase: XCTestCase {
	
	func test2D () {
		var v : vec2 = [1, 2]
		var scalarproduct : Double = 1 + 4
		var magnitude : Double = sqrt(scalarproduct)
		
		XCTAssertEqual(v, vec2(x: 1, y: 2), "Array assignment for vec2 passed.")
		XCTAssertEqual(v * v, scalarproduct, "Scalarproduct")
		XCTAssertEqual(v.magnitude, magnitude, "Magnitude")
		XCTAssertEqual(v.normalized, vec2(x: 1 / magnitude, y: 2 / magnitude), "Normalized")
		XCTAssertEqual(v.normal, vec2(x: -2, y: 1), "Normal")
		
		var w : vec2 = [7, -19]
		XCTAssertEqual(v * w, 7 * 1 + 2 * -19, "Scalarproduct")
		XCTAssertEqual(v + w, vec2(x: 8, y: -17), "Sum")
		XCTAssertEqual(v - w, vec2(x: -6, y: 21), "Difference")
		XCTAssertEqual(2 * w, vec2(x: 14, y: -38), "Product")
		
		var mat : mat2 = [1, 0, 0, 1]
		XCTAssertEqual(mat, mat2.identity, "")
	}
}
