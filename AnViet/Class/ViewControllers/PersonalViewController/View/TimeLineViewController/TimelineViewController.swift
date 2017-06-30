//
//  TimelineViewController.swift
//  AnViet
//
//  Created by Bui Giang on 6/28/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class TimelineViewController: AVBaseViewController {
    var timeLine:Timeline = Timeline()
    var user:UserInfor = UserInfor()
   
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let value:NSObject =  UserDefaults[.userInfor] as! NSObject
        let newValue = value as? [String : AnyObject]
        user = Mapper<UserInfor>().map(JSONObject: newValue)!
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.tableview.registerCellNib(TimeLineNoImageTableViewCell.self)
        self.tableview.registerCellNib(TimeLineHeaderTableViewCell.self)
        self.tableview.registerCellNib(TimeLineImageTableViewCell.self)
        
        self.getListPost(UserID: user.data.id, token: user.data.token, limit: "10",postId: "0",isload: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//MARK: CallAPi getlistpost
    func getListPost(UserID:String,token:String,limit:String,postId:String,isload:Bool) {
        self.showLoading()
        Alamofire.request(AVTimeLineRouter( endpoint: .getTimeLine(userId: UserID, token: token, limit: limit,postid: postId))).responseJSON { (response) in
            self.stopLoading()
            switch response.result {
            case .success(let value):
                let newValue = value as? [String : AnyObject]
                let data = Mapper<Timeline>().map(JSONObject: newValue)!
                if data.error.compare("FALSE") == .orderedSame {
                    if data.data.Post.count > 0 {
                        if isload {
                          self.timeLine.data.Post[0].post_data += data.data.Post[0].post_data
                        } else {
                            self.timeLine = data
                        }
                     
                    }
                    self.tableview.reloadData()
                } else {
                    let nameApplication = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
                    self.showAler(message: data.mess, title: nameApplication)
                }
            case .failure(_):
                print("AAAAA")
                break
            }
        }
    }
}
extension TimelineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.timeLine.data.Post.count > 0 {
            if self.timeLine.data.Post[0].post_data[indexPath.row].image.count > 0 {
                return 120
            } else {
                return 50
            }
        } else {
                return 50
        }

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeue(TimeLineHeaderTableViewCell.self)
        return headerCell
    }
}

extension TimelineViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.timeLine.data.Post.count > 0 {
            return self.timeLine.data.Post[0].post_data.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TimeLineNoImageTableViewCell.self)
        if self.timeLine.data.Post.count > 0 {
            if self.timeLine.data.Post[0].post_data[indexPath.row].image.count > 0 {
                let cell = tableView.dequeue(TimeLineImageTableViewCell.self)
                cell.configCell(title: self.timeLine.data.Post[0].post_data[indexPath.row].title, arrImage: self.timeLine.data.Post[0].post_data[indexPath.row].image,host: self.timeLine.host)
                return cell
            }
            cell.configCell(title:  self.timeLine.data.Post[0].post_data[indexPath.row].title)
        }
        
        return cell
    }
}

extension TimelineViewController : UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = CGFloat(offset.y + bounds.size.height - inset.bottom)
        let h = CGFloat(size.height)
        
        let reload_distance = CGFloat(10)
        if(y > (h + reload_distance)) {
            if self.timeLine.data.Post.count > 0 {
             self.getListPost(UserID: user.data.id, token: user.data.token, limit: "10",postId: self.timeLine.data.Post[0].post_data[self.timeLine.data.Post[0].post_data.count - 1].id,isload: true)
            }

        }
    }
}
