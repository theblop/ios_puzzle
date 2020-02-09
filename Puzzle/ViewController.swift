//
//  ViewController.swift
//  Puzzle
//
//  Created by Arnaud on 30/01/2020.
//  Copyright © 2020 Arnaud. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate {

    var pieces = ["puzz000", "puzz001", "puzz002", "puzz003"]
    //var itemsImg: [UIImage?] = []
    var rows = 2
    var cols = 2
    
    @IBOutlet var collection_view: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //itemsImg =  items.map { UIImage(named: $0) }
        collection_view.dragInteractionEnabled = true
        collection_view.dragDelegate = self
        collection_view.dropDelegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pieces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let img = pieces[indexPath.item]
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

    // set cell size based on number of tiles:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var w = view.frame.size.width
        w /= CGFloat(cols)
        
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = self.pieces[indexPath.row]
        
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item

        print("DRAG")
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        print("DROP")
        var destIndexPath: IndexPath
        if let IndexPath = coordinator.destinationIndexPath {
            destIndexPath = IndexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destIndexPath = IndexPath(item: row - 1, section : 0)
        }

        if coordinator.proposal.operation == .move {
            if let item = coordinator.items.first, let srcIndexPath = item.sourceIndexPath {
                collectionView.performBatchUpdates ({
                    pieces.swapAt(srcIndexPath.item, destIndexPath.item)
                    collectionView.reloadItems(at: [srcIndexPath, destIndexPath])
                }, completion: nil)
                coordinator.drop(item.dragItem, toItemAt: destIndexPath)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collection_view.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
}

