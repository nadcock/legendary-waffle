//
//  UserTableViewController.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let context = CoreDataStack.stack.context
    
    lazy var fetchedResultsController: NSFetchedResultsController =  {
        let fetchRequest = NSFetchRequest(entityName: "User")
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
            API.sharedInstance.loadData(.Users)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let resuseIdentifier = "cell"
        
        let user = fetchedResultsController.objectAtIndexPath(indexPath) as! User
        let company = user.company as! Company
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        
        cell.textLabel!.text = user.name
        cell.detailTextLabel!.text = company.name
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let userDetailView = UserDetailTableViewController()
        userDetailView.user = (fetchedResultsController.objectAtIndexPath(indexPath) as! User)
        self.navigationController?.pushViewController(userDetailView, animated: true)
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
            let user = controller.objectAtIndexPath(indexPath!) as! User
            let company = user.company as! Company
            cell.textLabel!.text = user.name
            cell.detailTextLabel!.text = company.name
            
            
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)

        }
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
}