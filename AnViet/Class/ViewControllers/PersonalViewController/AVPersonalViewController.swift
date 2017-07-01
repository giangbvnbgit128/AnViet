//
//  AVPersonalViewController.swift
//  AnViet
//
//  Created by Bui Giang on 5/28/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import ObjectMapper

class AVPersonalViewController: AVBaseViewController {
    @IBOutlet weak var tablView: UITableView!
    let arrImg = ["person","person","service","about","changepass","log","about","log"]
    var arrTitle:[String] = [] // ["Dell Latitude 420","Trần Ngọc Bắc","Gói dịch vụ","About us","Đổi mật khẩu", "Log out"]
    
    var user:UserInfor = UserInfor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tablView.delegate = self
        self.tablView.dataSource = self
        self.tablView.registerCellNib(AVProrsonalTableViewCell.self)
        
        let value:NSObject =  UserDefaults[.userInfor] as! NSObject
        let newValue = value as? [String : AnyObject]
        user = Mapper<UserInfor>().map(JSONObject: newValue)!
        
        arrTitle.append(user.data.name)
        arrTitle.append(user.data.computername)
        arrTitle.append("Gói dịch vụ")
        arrTitle.append("Đổi mật khẩu")
        arrTitle.append("Log out")
        arrTitle.append("About us")
        arrTitle.append("Review US")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension AVPersonalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60 * Ratio.widthIPhone6

    }
}

extension AVPersonalViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(AVProrsonalTableViewCell.self)
        cell.configCell(title: arrTitle[indexPath.row], image: arrImg[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // tên nguoi dung
            let userInforVC = UserInforViewController()
            AVMainViewController.ShareInstance.navigationController?.pushViewController(userInforVC, animated: true)
            break
        case 1: // tên may
            let mainSetting = MainSettingViewController()
            AVMainViewController.ShareInstance.navigationController?.pushViewController(mainSetting, animated: true)
            break

        case 2: // gói dich vụ
            break
        case 3:
            let changePassVC = AVChangePasswordViewController()
            AVMainViewController.ShareInstance.navigationController?.pushViewController(changePassVC, animated: true)
            break
        case 4:
            let tutorialVC = AVTutorialViewController()
            let navVC = AVBaseNavigationController( rootViewController: tutorialVC)
            AVMainViewController.ShareInstance.present(navVC, animated: false, completion: {
                
            })
            break
        case 5:
            let aboutUSVC = AVAboutUSViewController()
            AVMainViewController.ShareInstance.navigationController?.pushViewController(aboutUSVC, animated: true)
            break
        case 6:
            let reviewVC = AVReviewUSViewController()
            AVMainViewController.ShareInstance.navigationController?.pushViewController(reviewVC, animated: true)
            break
        default:
            break
        }
    }
}
