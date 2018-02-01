//
//  RecommendController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/24.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class RecommendController: MessageController {
    
    var dataArray:[MessageItem] = []
    var dataService:MessageService = MessageService(type: .recommend)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推荐"
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
    }
    
    override func refreshData() {
        dataService.fetch { (messageList, error) in
            if let messageLit = messageList?.data {
                
                var indexPathArray:[IndexPath] = []
                
                var index = 0
                for (_ ,message) in messageLit.enumerated() {
                    if message.type == "MESSAGE_RECOMMENDATION" {
                        indexPathArray.append(IndexPath(row: index, section: 0))
                        self.dataArray.insert(message, at: index)
                        index = index + 1
                    }
                }
                
                self.tableView.insertRows(at: indexPathArray, with: UITableViewRowAnimation.automatic)
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func messageItem(at indexPath: IndexPath) -> MessageItem? {
        if indexPath.row < self.dataArray.count {
            return self.dataArray[indexPath.row]
        } else {
            return nil
        }
    }
    
    override func loadMore() {
        dataService.loadMore { (messageList, error) in
            if let messageLit = messageList?.data {
                
                var indexPathArray:[IndexPath] = []
                
                var index = self.dataArray.count
                for (_ ,message) in messageLit.enumerated() {
                    if message.type == "MESSAGE_RECOMMENDATION" {
                        indexPathArray.append(IndexPath(row: index, section: 0))
                        self.dataArray.append(message)
                        index = index + 1
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
}

// tableDelegate
extension RecommendController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
}
