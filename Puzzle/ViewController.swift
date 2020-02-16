//
//  ViewController.swift
//  Puzzle
//
//  Created by Arnaud on 30/01/2020.
//  Copyright © 2020 Arnaud. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate {

    var puzzle: Puzzle?
    
    let defaults = UserDefaults.standard
    
    var myTimer: Timer!
    var timerSeconds = 0
    
    @IBOutlet var collection_view: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collection_view.dragInteractionEnabled = true
        collection_view.dragDelegate = self
        collection_view.dropDelegate = self
        startTimer()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return puzzle!.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let img = puzzle!.pieces_shuffled[indexPath.item]
        print("img=" + img)
        cell.cellImage.image = UIImage(named: img)
        return cell
    }

    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
 */

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
        w /= CGFloat(Double(puzzle!.size).squareRoot())
        //print("cell width: \(w)")
        
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = puzzle!.pieces_shuffled[indexPath.row]
        
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item

        //print("DRAG")
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        //print("DROP")
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
                    puzzle!.pieces_shuffled.swapAt(srcIndexPath.item, destIndexPath.item)
                    collectionView.reloadItems(at: [srcIndexPath, destIndexPath])
                }, completion: nil)
                coordinator.drop(item.dragItem, toItemAt: destIndexPath)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidEnd session: UIDropSession) {
        if puzzle!.pieces_shuffled == puzzle!.pieces {
            print("SOLVED !!")
            endTimer()
            let bestScore = view.viewWithTag(20) as! UILabel
            bestScore.text = String(timerSeconds)
            defaults.set(bestScore.text, forKey: "bestScore." + puzzle!.name)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collection_view.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeader", for: indexPath) as? HeaderView {
            header.timerLabel.text = "0"
            let best = defaults.integer(forKey: "bestScore." + puzzle!.name)
            header.bestScoreLabel.text = best != 0 ? String(best) : ""
            return header
        }
        return UICollectionReusableView()
    }
    
    func startTimer() {
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerSeconds += 1
        let timerLabel = view.viewWithTag(10) as! UILabel
        timerLabel.text = String(timerSeconds)
    }
    
    func endTimer() {
        myTimer.invalidate()
    }
}

