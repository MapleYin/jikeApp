//
//  STHJRecommendController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/24.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class STHJRecommendController: STHJTableViewController {
    
    var dataArray:[MessageItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推荐"

        tableView.register(STHJNormalMessageCell.self, forCellReuseIdentifier: String(describing: STHJNormalMessageCell.self))
        tableView.estimatedRowHeight = 100
    }
    
    override func reloadData() {
        MessageService.shared.recommendFeedList(false) { (messageList, error) in
            if let messageLit = messageList?.data {
                self.dataArray = messageLit + self.dataArray
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}

extension STHJRecommendController {
    
}

// tableDelegate
extension STHJRecommendController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: STHJNormalMessageCell.self)) as! STHJNormalMessageCell
        if let message = dataArray[indexPath.row].item as? Message {
            cell.setup(message)
            cell.updateConstraintsIfNeeded()
            return cell
        }
        
        return UITableViewCell()
    }
}
