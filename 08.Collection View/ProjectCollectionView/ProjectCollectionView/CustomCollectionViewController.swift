//
// Created by 刘庆文 on 10-20.
// Copyright (c) 2017 Liuqingwen. All rights reserved.
//

import Foundation
import UIKit

class CustomCollectionCell: UICollectionViewCell
{
    static let CELL_ID = "Cell"
    
    @IBOutlet weak var imageTitle:UIImageView!
    @IBOutlet weak var labelTitle:UILabel!
}

class CustomCollectionViewController: UICollectionViewController
{
    private static let SECTION_NUM = 1
    private var dataList = ["CafeDeadend", "Homei", "Teakha", "CafeLoisl", "PetiteOyster"
                            , "ForKeeRestaurant", "PosAtelier", "BourkeStreetBakery", "HaighsChocolate", "PalominoEspresso"
                            , "Upstate", "Traif", "GrahamAvenueMeats", "WaffleWolf", "FiveLeaves"
                            , "CafeLore", "Confessional", "Barrafina", "Donostia", "RoyalOak"
                            , "CaskPubKitchen"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Cannot use self.addGestureRecognizer here?
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(_:)))
        self.collectionView?.addGestureRecognizer(longPressGesture)
    }
    
    @objc func onLongPress(_ longPressGesture: UILongPressGestureRecognizer)
    {
        if(longPressGesture.state == UIGestureRecognizerState.began)
        {
            if let indexPath = self.collectionView?.indexPathForItem(at: longPressGesture.location(in: self.collectionView)) {
                let name = self.dataList[indexPath.row]
                let alert = UIAlertController(title: "Delete", message: "Do you want to delete the item: \(name)?", preferredStyle: .alert)
                let actionDone = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                    self.dataList.remove(at: indexPath.row)
                    self.collectionView?.reloadData()
                })
                let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(actionDone)
                alert.addAction(actionCancel)
                self.present(alert, animated: true)
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.dataList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.CELL_ID, for: indexPath) as! CustomCollectionCell
        cell.imageTitle.layer.cornerRadius = cell.imageTitle.bounds.height * 0.5
        cell.imageTitle.clipsToBounds = true
        
        cell.imageTitle.image = UIImage(named: self.dataList[indexPath.row].lowercased()) ?? UIImage(named: "photoalbum")
        cell.labelTitle.text = self.dataList[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction private func addNewItem(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add", message: "Add new one to list", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {textField in
            textField.placeholder = "New..."
        })
        let actionDone = UIAlertAction(title: "Add", style: .default, handler: {_ in
            if let text = alert.textFields?.first?.text {
                if(!text.isEmpty)
                {
                    self.dataList.append(text)
                    self.collectionView?.reloadData()
                }
            }
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionDone)
        alert.addAction(actionCancel)
        self.present(alert, animated: true)
    }
}

//For the collection view item layout
extension CustomCollectionViewController:UICollectionViewDelegateFlowLayout
{
    private static let ITEMS_PER_ROW = 2
    private static let SECTION_INSETS = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let paddings = CustomCollectionViewController.SECTION_INSETS.left * ((CGFloat)(CustomCollectionViewController.ITEMS_PER_ROW) + 1.0)
        let availableSpace = self.view.frame.width - paddings
        let itemWidth = availableSpace / (CGFloat)(CustomCollectionViewController.ITEMS_PER_ROW)
        return CGSize(width: itemWidth, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return CustomCollectionViewController.SECTION_INSETS
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return CustomCollectionViewController.SECTION_INSETS.left
    }
}