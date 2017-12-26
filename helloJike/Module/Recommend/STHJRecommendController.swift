//
//  STHJRecommendController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/24.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class STHJRecommendController: STHJTableViewController {
    
    var dataArray:[MessageItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推荐"
        
        
        tableView.register(STHJNormalMessageCell.self, forCellReuseIdentifier: String(describing: STHJNormalMessageCell.self))
        
        
        MessageService.shared.recommendFeedList { (messageList, error) in
            if let messageLit = messageList?.data {
                self.dataArray = messageLit
                self.tableView.reloadData()
            }
        }
    }
    
    
    
}

// tableDelegate
extension STHJRecommendController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataArray = self.dataArray {
            return dataArray.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: STHJNormalMessageCell.self)) as! STHJNormalMessageCell
        if let dataArray = dataArray {
            if let message = dataArray[indexPath.row].item as? Message {
                cell.setup(message)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
