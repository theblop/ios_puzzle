//
//  MenuViewController.swift
//  Puzzle
//
//  Created by Arnaud on 12/02/2020.
//  Copyright © 2020 Arnaud. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MenuViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var puzzles: [Puzzle] = []
    //var puzzle_idx = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
               
        for puzzname in [
            "cessange_rainbow",
            "cessange_sunrise",
            "grand_canyon",
            "kockelscheuer_happy",
            "kockelscheuer_winter",
            "nz_cook",
            "nz_hills",
            "nz_rainbow",
            "nz_sunset",
            "slovenia_lake",
            "slovenia_lake2",
            "vosges_iron",
        ] {
            puzzles.append(Puzzle(name: puzzname, size: 9))
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    
        if let cell = sender as? UICollectionViewCell,
            let indexPath = self.collectionView.indexPath(for: cell) {
            //let nav = segue.destination as! UINavigationController
            //let vc = nav.topViewController as! ViewController
            let vc = segue.destination as! ViewController
            vc.puzzle = puzzles[indexPath.row]
        }
        //    let vc = segue.destination as! ViewController
    //    vc.puzzle = puzzles[puzzle_idx]
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return puzzles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
    
        // Configure the cell
        let puzzle = puzzles[indexPath.row]
        let img = UIImage(named: puzzle.name)
        cell.imageView.image = img
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    /*
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.puzzle_idx = indexPath.item
    }
     */
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    // set number of cells per row:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //var w = view.frame.size.width
        //w /= 4.0
        
        let n:CGFloat = 3.0
        let space:CGFloat = 10.0
        
        let total_space = (n+2) * space
        let w = (collectionView.bounds.width - total_space) / n
        
        return CGSize(width: w, height: w)
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    */

}
