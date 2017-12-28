//
//  RecommendController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/24.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class RecommendController: STTableViewController {
    
    var dataArray:[MessageItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推荐"
        
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }
    
    override func refreshData() {
        MessageService.shared.recommendFeedList(false) { (messageList, error) in
            if let messageLit = messageList?.data {
                
                var indexPathArray:[IndexPath] = []
                
                for (index,_) in messageLit.enumerated() {
                    indexPathArray.append(IndexPath(row: index, section: 0))
                }
                
                self.dataArray = messageLit + self.dataArray
                
                self.tableView.insertRows(at: indexPathArray, with: UITableViewRowAnimation.automatic)
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func cellToRegist() -> [BaseCell.Type] {
        return [MessageCell.self,MessageTextCell.self,MessageImageCell.self,MessageMultipleImageCell.self]
    }
}

extension RecommendController {
    
}

// tableDelegate
extension RecommendController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageItem = dataArray[indexPath.row]
        var cell = UITableViewCell()
        if let message = messageItem.item as? Message {
            
            if let picUrls = message.pictureUrls,
                picUrls.count > 0 {
                if picUrls.count == 1 {
                    let messageCell = tableView.dequeueReusableCell(withIdentifier: MessageImageCell.identifier, for: indexPath) as! MessageImageCell
                    messageCell.setup(message: message)
                    cell = messageCell
                } else {
                    let messageCell = tableView.dequeueReusableCell(withIdentifier: MessageMultipleImageCell.identifier, for: indexPath) as! MessageMultipleImageCell
                    messageCell.setup(message: message)
                    cell = messageCell
                }
            } else {
                let messageCell = tableView.dequeueReusableCell(withIdentifier: MessageTextCell.identifier, for: indexPath) as! MessageTextCell
                messageCell.setup(message: message)
                cell = messageCell
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
