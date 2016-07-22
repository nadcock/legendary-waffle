//
//  UserNavigationController.swift
//  Solution
//
//  Created by Nick on 7/21/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import UIKit

class UserNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let userTableView = UserTableViewController()
        userTableView.title = "Users"
        self.pushViewController(userTableView, animated: false)
        
    }
}