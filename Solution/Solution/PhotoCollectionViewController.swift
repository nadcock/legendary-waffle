//
//  PhotoCollectionViewController.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    var album: Album?
    let context = CoreDataStack.stack.context
    let reuseIdenifier = "PhotoCell"
    
    lazy var fetchedResultsController: NSFetchedResultsController =  {
        let fetchRequest = NSFetchRequest(entityName: "Photo")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "album = %@", self.album!)
        
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: self.context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        collectionView?.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdenifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {}
        
        navigationItem.title = "Photos"
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let photo = fetchedResultsController.objectAtIndexPath(indexPath) as! Photo
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdenifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        API.sharedInstance.downloadPhoto(photo.thumbnailURL!) { (downloadedPhoto: NSData) -> Void in
            let processedImage = UIImage(data: downloadedPhoto)
            
            dispatch_async(dispatch_get_main_queue()) {
                cell.setDownloadedImage(processedImage!)
            }
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let photo = fetchedResultsController.objectAtIndexPath(indexPath) as! Photo
        let photoViewController = PhotoViewController()
        photoViewController.photo = photo
        navigationController?.pushViewController(photoViewController, animated: false)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let numberOfItemsPerRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumLineSpacing = 2
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        return CGSize(width: size, height: size)
    }
    
//    func printFetchedObjects(photos: [Photo]) {
//        print("FETCHED OBJECTS")
//        for photo in photos {
//            print("Photo ID: \(photo.id!), PHOTO ALBUM ID: \((photo.album as! Album).id!)")
//        }
//        
//    }
    
}