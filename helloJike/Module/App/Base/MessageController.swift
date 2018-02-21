//
//  MessageController.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/18.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import AVKit
import Kingfisher

class MessageController: STTableViewController {
    
    var customTransition:UIViewControllerTransitioningDelegate?
    
    private var currentMessageMultipleImageCell : MessageMediaCell?
    private var currentSelectedImageViewIndex : Int = 0
    private var isStatusBarHidden = false
    
    private let playerView = PlayerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 300
        
    }
    
    override func cellToRegist() -> [BaseCell.Type] {
        return [MessageMediaCell.self,MessageTextImageCell.self]
    }
    
    func viewModel(at indexPath:IndexPath) -> Any? {
        return nil
    }
    
    func model(at indexPath:IndexPath) -> Any? {
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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
}

// MARK: - TableViewDelegate
extension MessageController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        guard let viewModel = self.viewModel(at: indexPath)  else {
            return cell
        }
        
        
        if let viewModel = viewModel as? MessageViewModel {
        
            if viewModel.cellType == .media {
                let messageMediaCell = tableView.dequeueReusableCell(withIdentifier: MessageMediaCell.identifier, for: indexPath) as! MessageMediaCell
                messageMediaCell.delegate = self
                messageMediaCell.mediaDelegate = self
                messageMediaCell.setup(viewModel: viewModel)
                cell = messageMediaCell
            } else if viewModel.cellType == .imageText {
                let messageTextImageCell = tableView.dequeueReusableCell(withIdentifier: MessageTextImageCell.identifier, for: indexPath) as! MessageTextImageCell
                messageTextImageCell.delegate = self
                messageTextImageCell.setup(viewModel: viewModel)
                cell = messageTextImageCell
            }
        } else {
            print(viewModel)
        }
        
        if indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1 {
            loadMore()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? MessageMediaCell {
            videoCell.removePlayerIfNeeded()
        }
    }
}


// MARK: - MessageMediaCellAction

extension MessageController : MessageMediaCellAction {
    
    func messageCell(_ cell: MessageCell, action: MessageBottomView.ActionType) {
        if let indexPath = tableView.indexPath(for: cell) {
            switch action {
            case .like:
                break
            case .comment:
                
                if let message = model(at: indexPath) as? FeedMessage {
                    var messageId = message.id
                    var commentType:CommentService.CommentType = .message
                    if let userMessage = message.personalUpdate {
                        messageId = userMessage.id
                        commentType = .personalUpdate
                    }
                    let commentController = CommentController(messageId,type:commentType)
                    self.navigationController?.pushViewController(commentController, animated: true)
                } else if let message = model(at: indexPath) as? UserMessage {
                    let messageId = message.id
                    let commentController = CommentController(messageId, type:.personalUpdate)
                    self.navigationController?.pushViewController(commentController, animated: true)
                }
                break
            case .share:
                if let message = model(at: indexPath) as? FeedMessage {
                    var item:[Any] = []
                    
                    if let url = URL(string:message.originalLinkUrl) {
                        item.append(url)
                    }
                    item.append(message.content)
                    if let imageData = message.deepFetchImages()?.first,
                        let url = URL(string: imageData.thumbnailUrl) {
                        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
                            if let image = image {
                                item.append(image)
                            }
                            
                            let vc = UIActivityViewController(activityItems: item, applicationActivities: nil)
                            self.present(vc, animated: true, completion: nil)
                        })
                    } else {
                        let vc = UIActivityViewController(activityItems: item, applicationActivities: nil)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                
                break
            }
        }
        
    }
    
    func messageCell(_ cell: MessageMediaCell, imageViews: [ImageView], index: Int) {
        if let indexPath = tableView.indexPath(for: cell),
            let model = self.model(at: indexPath),
            let message = model as? Message,
            let images = message.deepFetchImages(),
            images.count > 0 {

            
            currentMessageMultipleImageCell = cell
            currentSelectedImageViewIndex = index
            
            customTransition = ImageDetailTransitionDelegate()
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
    
    func messageCell(_ cell: MessageMediaCell, playVideo player: (PlayerView) -> Void) {
        if let indexPath = tableView.indexPath(for: cell),
            let model = self.model(at: indexPath),
            let message = model as? Message {
            playerView.setup(message: message)
            player(playerView)
        }
    }

}


// MARK: - ImageDetailTransitionProtocol
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
