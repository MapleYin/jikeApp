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
        
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.line
        tableView.separatorInset = UIEdgeInsets.zero
        
        
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.barHideOnTapGestureRecognizer.addTarget(self, action: #selector(swipe))
    }
    
    @objc func swipe(_ recognizer:UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.2) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return (navigationController?.isNavigationBarHidden)!
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func refreshData() {
        MessageService.shared.recommendFeedList(false) { (messageList, error) in
            if let messageLit = messageList?.data {
                
                var indexPathArray:[IndexPath] = []
                
                var index = 0
                for (_ ,message) in messageLit.enumerated() {
                    if message.type == "MESSAGE_RECOMMENDATION" {
                        indexPathArray.append(IndexPath(row: index, section: 0))
                        self.dataArray.append(message)
                        index = index + 1
                    }
                }
                
                self.tableView.insertRows(at: indexPathArray, with: UITableViewRowAnimation.automatic)
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func cellToRegist() -> [BaseCell.Type] {
        return [MessageCell.self,MessageTextCell.self,MessageMultipleImageCell.self,MessageVideoCell.self]
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
                let messageCell = tableView.dequeueReusableCell(withIdentifier: MessageMultipleImageCell.identifier, for: indexPath) as! MessageMultipleImageCell
                messageCell.setup(message: message)
                cell = messageCell
            } else if message.video != nil {
                let videoCell = tableView.dequeueReusableCell(withIdentifier: MessageVideoCell.identifier, for: indexPath) as! MessageVideoCell
                videoCell.setup(message: message)
                cell = videoCell
            } else {
                let messageCell = tableView.dequeueReusableCell(withIdentifier: MessageTextCell.identifier, for: indexPath) as! MessageTextCell
                messageCell.setup(message: message)
                cell = messageCell
            }
        } else {
            print(messageItem)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let messageItem = dataArray[indexPath.row]
        
        if let message = messageItem.item as? Message {
            if let images = message.pictureUrls,
                images.count > 0{
                let vc = ImageDetailController(images)
                present(vc, animated: true, completion: nil)
            } else if let urlString = message.originalLinkUrl,
                let url = URL(string: urlString) {
                let safariVC = OriginDetailController(url: url)
                present(safariVC, animated: true, completion: nil)
            } else {
                
            }
        }
    }
}
