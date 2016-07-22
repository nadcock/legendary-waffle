//
//  UserViewContoller.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import UIKit
import Static

class UserDetailTableViewController: TableViewController {
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(user!.name!)"
        
        let address = user!.address as! Address
        let company = user!.company as! Company
        
        dataSource.sections = [
            Section(header: "Info", rows: [
                Row(text: "Name", detailText: "\(user!.name!)", cellClass: Value1Cell.self),
                Row(text: "Username", detailText: "\(user!.username!)", cellClass: Value1Cell.self),
                Row(text: "Company", detailText: "\(company.name!)", cellClass: Value1Cell.self, accessory: .DisclosureIndicator, selection: { [unowned self] in
                    let companyVC = CompanyDetailTableViewController()
                    companyVC.company = company
                    self.navigationController?.pushViewController(companyVC, animated: true)
                    }),
                ]),
            Section(header: "Contact", rows: [
                Row(text: "Email", detailText: "\(user!.email!)", cellClass: Value1Cell.self),
                Row(text: "Phone", detailText: "\(user!.phone!)", cellClass: Value1Cell.self),
                Row(text: "Website", detailText: "\(user!.website!)", cellClass: Value1Cell.self),
                ]),
            Section(header: "Address", rows: [
                Row(text: "Street", detailText: "\(address.street!)", cellClass: Value1Cell.self),
                Row(text: "Suite", detailText: "\(address.suite!)", cellClass: Value1Cell.self),
                Row(text: "City", detailText: "\(address.city!)", cellClass: Value1Cell.self),
                Row(text: "Zip", detailText: "\(address.zip!)", cellClass: Value1Cell.self),
                ])
        ]

    }
    
}