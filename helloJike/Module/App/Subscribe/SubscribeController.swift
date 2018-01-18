//
//  SubscribeController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import AVKit

class SubscribeController: STTableViewController {

    var dataArray:[MessageItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订阅"
        
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.line
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    
    override func refreshData() {
        MessageService.shared.newsFeed { (messageList, error) in
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
        MessageService.shared.newsFeedLoadMore { (messageList, error) in
            if let messageLit = messageList?.data {
                
                var indexPathArray:[IndexPath] = []
                
                var index = self.dataArray.count - 1
                for (_ ,message) in messageLit.enumerated() {
                    if message.type == "MESSAGE" {
                        indexPathArray.append(IndexPath(row: index, section: 0))
                        self.dataArray.append(message)
                        index = index + 1
                    }
                }
                
                self.tableView.insertRows(at: indexPathArray, with: UITableViewRowAnimation.automatic)
            }
        }
    }
    
    
    override func cellToRegist() -> [BaseCell.Type] {
        return [MessageCell.self,MessageTextCell.self,MessageMultipleImageCell.self,MessageVideoCell.self]
    }
}

// tableDelegate
extension SubscribeController {
        
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
        
        if indexPath.row == self.dataArray.count - 1 {
            loadMore()
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
            } else if message.video != nil {
                let videoPlayerVC = AVPlayerViewController()
                present(videoPlayerVC, animated: true, completion: {
                    message.videoUrl({ (item) in
                        if item != nil{
                            let player = AVPlayer(playerItem: item)
                            videoPlayerVC.player = player
                            videoPlayerVC.player?.play()
                        }
                    })
                })
            } else if let urlString = message.originalLinkUrl,
                let url = URL(string: urlString) {
                let safariVC = OriginDetailController(url: url)
                present(safariVC, animated: true, completion: nil)
            } else {
                
            }
        }
    }
}

