//
//  CollectionViewCell.swift
//  Puzzle
//
//  Created by Arnaud on 30/01/2020.
//  Copyright © 2020 Arnaud. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellContent: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        self.frame = cellImage.frame
    }
}
