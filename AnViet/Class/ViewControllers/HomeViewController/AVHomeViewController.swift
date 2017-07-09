//
//  AVHomeViewController.swift
//  AnViet
//
//  Created by Bui Giang on 5/28/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class AVHomeViewController: AVBaseViewController {

//    let heightForNoImage:CGFloat = 127
    
    var cacheId:String = "0"
    @IBOutlet weak var tableView: UITableView!
    
    var newsFeeds:NewsItem = NewsItem()
    var user:UserInfor = UserInfor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setUpTable()
        user = AVDatamanager.ShareInstance.UserManager
        AVMainViewController.ShareInstance.blockReloadData = {() in
            self.getData()
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
    }
    
    func getData() {
        self.getNewsFeed(userid: user.data.id, token: user.data.token, limit: "10", postid: "0",isloadMore: false)
    }
    
    func setUpTable() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerCellNib(AVNewFeedNoImageTableViewCell.self)
        self.tableView.registerCellNib(AVNewFeedOneImageTableViewCell.self)
        self.tableView.registerCellNib(AVNewFeedTwoImageTableViewCell.self)
        self.tableView.registerCellNib(AVNewFeedThreeImageTableViewCell.self)
        self.tableView.registerCellNib(AVNewFeedFourImageTableViewCell.self)
        self.tableView.registerCellNib(AVNewFeedFiveImageTableViewCell.self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
//MARK - : Call APi Get Newfeed
    func getNewsFeed(userid:String,token:String,limit:String,postid:String,isloadMore:Bool) {
       self.showLoading()
        Alamofire.request(AVNewsFeedRouter( endpoint: .NewsFeed(userId: userid, token: token, litmit: limit, post_id: postid))).responseJSON { (response) in
            self.stopLoading()
            switch response.result {
            case .success(let value):
                let newValue = value as? [String : AnyObject]
                let arrayNewsFeeed:NewsItem = Mapper<NewsItem>().map(JSONObject: newValue)!
                if arrayNewsFeeed.error.compare("FALSE") == .orderedSame {
                    if isloadMore {
                        self.newsFeeds.data += arrayNewsFeeed.data
                    } else {
                        self.newsFeeds = NewsItem()
                        self.newsFeeds = arrayNewsFeeed
                    }
                    self.tableView.reloadData()
                } else {
                    self.showAler(message: arrayNewsFeeed.message, title: "Error")
                }
            case .failure(let error):
                print("Error Request = \(error)")
                break
            }
        }
   
    }
    
}
extension AVHomeViewController: UITableViewDelegate {

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 419
//    }
}
extension AVHomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsFeeds.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.newsFeeds.data[indexPath.row]
        let host:String = self.newsFeeds.host
        
        switch item.post.image.count {
        case 0:
            let cell = tableView.dequeue(AVNewFeedNoImageTableViewCell.self)
            cell.configCell( data: item, host: host,vc:self)
            return cell
        case 1:
            let cell = tableView.dequeue(AVNewFeedOneImageTableViewCell.self)
            cell.configCell(data: item, host: host, vc: self)
            return cell
        case 2:
            let cell = tableView.dequeue(AVNewFeedTwoImageTableViewCell.self)
            cell.configCell(data: item, host: host,vc: self)
            return cell
        case 3:
            let cell = tableView.dequeue(AVNewFeedThreeImageTableViewCell.self)
            cell.configCell(data: item, host: host, vc: self)
            return cell
        case 4:
            let cell = tableView.dequeue(AVNewFeedFourImageTableViewCell.self)
            cell.configCell(data: item, host: host,vc: self)
            return cell
        default:
            let cell = tableView.dequeue(AVNewFeedFiveImageTableViewCell.self)
            cell.configCell(data: item, host: host, vc:self)
            return cell
        }
    }
}

extension AVHomeViewController : UIScrollViewDelegate {
   public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = CGFloat(offset.y + bounds.size.height - inset.bottom)
        let h = CGFloat(size.height)
        
        let reload_distance = CGFloat(10)
        if(y > (h + reload_distance)) {
           DispatchQueue.main.async(execute: {
            if self.newsFeeds.data.count > 0 {
                let idIndex = self.newsFeeds.data[self.newsFeeds.data.count - 1].post.id
                if self.cacheId != idIndex {
                    self.cacheId = idIndex
                    self.getNewsFeed(userid: self.user.data.id, token: self.user.data.token, limit: "10", postid: idIndex, isloadMore: true)
                }

            }
           })
        }
    }
}
