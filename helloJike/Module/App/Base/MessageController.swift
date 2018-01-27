//
//  MessageController.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/18.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import AVKit

class MessageController: STTableViewController {
    
    let customTransition = ImageDetailTransitionDelegate()
    
    
    //
    
    private var currentMessageMultipleImageCell : MessageMultipleImageCell?
    private var currentSelectedImageViewIndex : Int = 0
    private var isStatusBarHidden = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 300
    }
    
    override func cellToRegist() -> [BaseCell.Type] {
        return [MessageCell.self,MessageTextCell.self,MessageMultipleImageCell.self,MessageVideoCell.self]
    }
    
    func messageItem(at indexPath:IndexPath) -> MessageItem? {
        return nil
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isStatusBarHidden {
            isStatusBarHidden = false
            UIView.animate(withDuration: 0.25) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
}

// TableViewDelegate
extension MessageController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        guard let messageItem = self.messageItem(at: indexPath)  else {
            return cell
        }
        
        
        if let message = messageItem.item as? Message {
            
            if let picUrls = message.pictureUrls,
                picUrls.count > 0 {
                let messageCell = tableView.dequeueReusableCell(withIdentifier: MessageMultipleImageCell.identifier, for: indexPath) as! MessageMultipleImageCell
                messageCell.delegate = self
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

        guard let messageItem = self.messageItem(at: indexPath)  else {
            return
        }
        
        if let message = messageItem.item as? Message {
            if let urlString = message.originalLinkUrl,
                urlString.hasPrefix("http") == true {
                let url = URL(string: urlString)
                let safariVC = OriginDetailController(url: url!)
                present(safariVC, animated: true, completion: nil)
            } else {
                print(message.originalLinkUrl ?? "")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 2 {
            loadMore()
        }
    }
}


// MessageMultipleImageCellAction

extension MessageController : MessageMultipleImageCellAction {
    
    
    
    func messageCell(_ cell: MessageMultipleImageCell, imageViews: [ImageView], index: Int) {
        if let indexPath = tableView.indexPath(for: cell),
            let messageItem = self.messageItem(at: indexPath),
            let message = messageItem.item as? Message,
            let images = message.pictureUrls,
            images.count > 0{
            
            currentMessageMultipleImageCell = cell
            currentSelectedImageViewIndex = index

            
            let vc = ImageDetailController(images, selected: index, source: imageViews)
            vc.modalPresentationStyle = .fullScreen
            vc.transitioningDelegate = customTransition
            
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.25) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
            
            present(vc, animated: true, completion: nil)
        }
    }
}

// ImageDetailTransitionProtocol

extension MessageController : ImageDetailTransitionProtocol {
    
    func sourceImageView(at index: Int) -> (ImageView, CGRect)? {
        if let cell = currentMessageMultipleImageCell {
            var (imageView,rect) = cell.selectedImageViewRect(at: index)
            rect = cell.convert(rect, to: self.view)
            return (imageView,rect)
        }
        return nil
    }
}
