//
//  SubscribeController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import AVKit

class SubscribeController: MessageController {

    var dataArray:[MessageItem] = []
    var dataService:MessageService = MessageService(type: .subscribe)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订阅"
        
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
    }
    
    
    override func refreshData() {
        dataService.fetch { (messageList, error) in
            if let messageLit = messageList?.data {
                
                var indexPathArray:[IndexPath] = []
                
                var index = 0
                for (_ ,message) in messageLit.enumerated() {
                    if message.type == "MESSAGE" {
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
    
    override func loadMore() {
        dataService.loadMore { (messageList, error) in
            if let messageLit = messageList?.data {
                
                var indexPathArray:[IndexPath] = []
                
                var index = self.dataArray.count
                for (_ ,message) in messageLit.enumerated() {
                    if message.type == "MESSAGE" {
                        indexPathArray.append(IndexPath(row: index, section: 0))
                        self.dataArray.append(message)
                        index = index + 1
                    }
                }
                self.tableView.insertRows(at: indexPathArray, with: .automatic)
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
}

// tableDelegate
extension SubscribeController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
}

