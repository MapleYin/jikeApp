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

// TableViewDelegate
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
                messageMediaCell.setup(viewModel: viewModel)
                cell = messageMediaCell
            } else if viewModel.cellType == .imageText {
                let messageTextImageCell = tableView.dequeueReusableCell(withIdentifier: MessageTextImageCell.identifier, for: indexPath) as! MessageTextImageCell
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
        
        if let message = model as? Message {
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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? MessageMediaCell {
            videoCell.removePlayerIfNeeded()
        }
    }
}


// MARK: - MessageMediaCellAction

extension MessageController : MessageMediaCellAction {
    func messageCell(_ cell: MessageMediaCell, imageViews: [ImageView], index: Int) {
        if let indexPath = tableView.indexPath(for: cell),
            let model = self.model(at: indexPath),
            let message = model as? Message,
            let images = message.pictureUrls,
            images.count > 0{
            
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
