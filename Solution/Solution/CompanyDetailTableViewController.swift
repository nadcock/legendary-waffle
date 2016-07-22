//
//  CompanyDetailTableViewController.swift
//  Solution
//
//  Created by Nick on 7/21/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import UIKit
import Static

class CompanyDetailTableViewController: TableViewController {
    var company: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(company!.name!)"
        
        dataSource.sections = [
            Section(header: "Company Info", rows: [
                Row(text: "Name", detailText: "\(company!.name!)", cellClass: Value1Cell.self),
                Row(text: "Catch Phrase", detailText: "\(company!.catchPhrase!)", cellClass: Value1Cell.self),
                Row(text: "BS", detailText: "\(company!.bs!)", cellClass: Value1Cell.self),
                ]),
        ]
        
    }
    
}