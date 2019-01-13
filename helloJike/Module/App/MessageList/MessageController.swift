//
//  MessageController.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/18.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MessageController: STTableViewController {
    
    let messageService = STJMessageManager(type: .subscribe)
    var messageViewModelList = [MessageViewModel]()
    var messageModelList = [Message]()
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func model(at indexPath:IndexPath) -> Message? {
        if indexPath.row < messageModelList.count {
            return messageModelList[indexPath.row]
        }
        return nil
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        context.beginBatchFetching()
        messageService.loadMore { (response, error) in
            if error != nil {
                
            } else if let data = response?.data {
                var indexPathArray:[IndexPath] = []
                var index = self.messageViewModelList.count
                data.forEach({ (messageItem) in
                    if let message = messageItem.item as? FeedMessage {
                        indexPathArray.append(IndexPath(row: index, section: 0))
                        self.messageModelList.append(message)
                        self.messageViewModelList.append(MessageViewModel(feedMessage: message))
                        index = index + 1
                    }
                })
                self.tableView.insertRows(at: indexPathArray, with: .none)
            }
            
            context.completeBatchFetching(true)
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return messageViewModelList.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let messageModel = messageViewModelList[indexPath.row]
        return { () -> ASCellNode in
            return MessageCell(messageModel: messageModel)
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        guard let model = self.model(at: indexPath)  else {
            return
        }
        
        if let feedMessage = model as? FeedMessage {
            if feedMessage.originalLinkUrl.hasPrefix("http") == true,
                let url = URL(string: feedMessage.originalLinkUrl) {
                let safariVC = OriginDetailController(url: url)
                present(safariVC, animated: true, completion: nil)
            } else {
                print(feedMessage.originalLinkUrl)
            }
        }
    }

}
