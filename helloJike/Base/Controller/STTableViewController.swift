//
//  STTableViewController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class STTableViewController: ASViewController<ASTableNode>,ASTableDelegate,ASTableDataSource {
    
    var tableView:ASTableNode = ASTableNode(style: .plain)
    
    init() {
        super.init(node: tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
