//
//  Puzzle.swift
//  Puzzle
//
//  Created by Arnaud on 12/02/2020.
//  Copyright © 2020 Arnaud. All rights reserved.
//

import UIKit

class Puzzle: NSObject {
    var name: String
    var size: Int
    var pieces: [String]
    var pieces_shuffled: [String]
    
    init(name: String, size: Int) {
        self.name = name
        self.size = size
        self.pieces = (0...size).map {String(format: "%003d", $0)}
        self.pieces_shuffled = self.pieces.shuffled()
    }
}
