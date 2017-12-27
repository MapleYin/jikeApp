//
//  RecommendController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/24.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class RecommendController: BaseTableViewController {
    
    var dataArray:[MessageItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推荐"

        
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
    
    override func cellToRegist() -> [BaseCell.Type] {
        return [MessageCell.self,MessageTextCell.self,MessageImageCell.self]
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
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
