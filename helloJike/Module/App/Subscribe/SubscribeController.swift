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

    var modelArray:[FeedMessage] = []
    var viewModelArray:[Any] = []
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
                
                if self.tableView.visibleCells.count > 0 {
                    self.tableView.reloadData()
                }
                
                var index = 0
                for (_ ,messageItem) in messageLit.enumerated() {
                    if messageItem.type == .message ,
                        let message = messageItem.item as? FeedMessage {
                        indexPathArray.append(IndexPath(row: index, section: 0))
                        self.modelArray.insert(message, at: index)
                        self.viewModelArray.append(MessageViewModel(feedMessage: message))
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
                
                var index = self.modelArray.count
                for (_ ,messageItem) in messageLit.enumerated() {
                    if messageItem.type == .message ,
                        let message = messageItem.item as? FeedMessage {
                        indexPathArray.append(IndexPath(row: index, section: 0))
                        self.modelArray.append(message)
                        self.viewModelArray.append(MessageViewModel(feedMessage: message))
                        index = index + 1
                    }
                }
                self.tableView.reloadData()
//                self.tableView.insertRows(at: indexPathArray, with: .automatic)
            }
        }
    }

    
    override func viewModel(at indexPath: IndexPath) -> Any? {
        if indexPath.row < self.viewModelArray.count {
            return self.viewModelArray[indexPath.row]
        } else {
            return nil
        }
    }
    
    override func model(at indexPath: IndexPath) -> Any? {
        if indexPath.row < self.modelArray.count {
            return self.modelArray[indexPath.row]
        } else {
            return nil
        }
    }
}

// tableDelegate
extension SubscribeController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModelArray.count
    }
}

