//
//  CommentController.swift
//  helloJike
//
//  Created by Mapleiny on 2018/2/7.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class CommentController: STTableViewController {
    
    private let messageId:String
    
    private let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    private let commentService:CommentService
    
    var modelArray:[Comment] = []
    var viewModelArray:[CommentViewModel] = []
    
    init(_ messageId:String) {
        self.messageId = messageId
        self.commentService = CommentService(messageId: messageId)
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshData()
    }
    
    override func cellToRegist() -> [BaseCell.Type] {
        return [CommentCell.self]
    }
    
    func viewModel(at indexPath:IndexPath) -> CommentViewModel? {
        if indexPath.row < self.viewModelArray.count {
            return self.viewModelArray[indexPath.row]
        } else {
            return nil
        }
    }
    
    func model(at indexPath:IndexPath) -> Comment? {
        if indexPath.row < self.modelArray.count {
            return self.modelArray[indexPath.row]
        } else {
            return nil
        }
    }
    
    
    override func refreshData() {
        commentService.loadComment { (commentList, error) in
            if let commentList = commentList {
                self.modelArray = commentList.data
                self.viewModelArray = []
                commentList.data.forEach({ (comment) in
                    let commentViewModel = CommentViewModel(comment)
                    self.viewModelArray.append(commentViewModel)
                })
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func loadMore() {
        commentService.loadMoreData { (commentList, error) in
            if let commentList = commentList {
                self.modelArray.append(contentsOf: commentList.data)
                commentList.data.forEach({ (comment) in
                    let commentViewModel = CommentViewModel(comment)
                    self.viewModelArray.append(commentViewModel)
                })
                
                self.tableView.reloadData()
            }
        }
    }
}


// MARK: - TableViewDelegate

extension CommentController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        guard let viewModel = self.viewModel(at: indexPath)  else {
            return cell
        }
        
        let commentCell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        
        commentCell.setup(viewModel)
        
        cell = commentCell
        
        if indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1 {
            loadMore()
        }
        
        return cell
    }
}

// tableDelegate
extension CommentController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModelArray.count
    }
}
