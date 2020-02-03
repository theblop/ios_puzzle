//
//  ViewController.swift
//  Puzzle
//
//  Created by Arnaud on 30/01/2020.
//  Copyright © 2020 Arnaud. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

//    var items = ["A", "B", "C", "D"]
    var items = ["tile000", "tile001", "tile002", "tile003"]
    var photos = [
        ["alps": 4]
    ]
    var rows = 2
    var cols = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.cellContent.text = items[indexPath.item]
        let img = "alps/" + items[indexPath.item]
        //print("xxx: \(img) : " + String(indexPath.item))
        cell.cellImage.image = UIImage(named: img)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }

    // set cellview cell margins to 0:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }

    // set cell size based on number of tiles:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var w = view.frame.size.width
        var h = view.frame.size.height
        print("frame w/h: \(w)/\(h)")
        w /= CGFloat(cols)
        h /= CGFloat(rows)
        //print("cell w/h: \(w)/\(h)")
        return CGSize(width: w, height: h)
    }
    
}

