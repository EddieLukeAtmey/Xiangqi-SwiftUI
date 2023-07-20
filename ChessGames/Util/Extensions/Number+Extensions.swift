//
//  Number+Extensions.swift
//  Xiangqi
//
//  Created by Eddie on 19/07/2023.
//

import Foundation

extension BinaryInteger {
    func isIn(_ r: ClosedRange<Self>) -> Bool { return r.contains(self) }
}
