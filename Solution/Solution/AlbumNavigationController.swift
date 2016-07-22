//
//  AlbumNavigationController.swift
//  Solution
//
//  Created by Nick Adcock on 7/20/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import UIKit

class AlbumNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let albumViewController = AlbumTableViewController()
        self.pushViewController(albumViewController, animated: false)
        self.title = "Photos"
    }
}