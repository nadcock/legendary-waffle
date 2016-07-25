//
//  AlbumViewController.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AlbumTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let context = CoreDataStack.stack.context
    
    lazy var fetchedResultsController: NSFetchedResultsController =  {
        let fetchRequest = NSFetchRequest(entityName: "Album")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: self.context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {}
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if fetchedResultsController.fetchedObjects?.count < 1 {
            API.sharedInstance.loadData(.Photos)
        }
        navigationItem.title = "Albums"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let album = fetchedResultsController.objectAtIndexPath(indexPath) as! Album
        let albumTitle = "Album # \(album.id!)"
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        cell.textLabel!.text = albumTitle

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let photoViewController = PhotoCollectionViewController(collectionViewLayout: layout)
        photoViewController.album = (fetchedResultsController.objectAtIndexPath(indexPath) as! Album)
        self.navigationController?.pushViewController(photoViewController, animated: true)
    }

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController,
                    didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
                                     atIndex sectionIndex: Int,
                                             forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            
        default:
            return
        }
    }
    
    func controller(controller: NSFetchedResultsController,
                    didChangeObject anObject: AnyObject,
                                    atIndexPath indexPath: NSIndexPath?,
                                                forChangeType type: NSFetchedResultsChangeType,
                                                              newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            
        case .Update:
            guard let viewableIndexPath = indexPath else {
                print("invalid index path")
                return
            }
            guard let cell = tableView.cellForRowAtIndexPath(viewableIndexPath) else {
                return
            }
            let album = controller.objectAtIndexPath(indexPath!) as! Album
            let albumTitle = "Album # \(album.id!)"
            cell.textLabel!.text = albumTitle
            
            
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            
        }
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
}