//
//  MainSettingViewController.swift
//  AnViet
//
//  Created by Bui Giang on 6/28/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class MainSettingViewController: AVBaseViewController , UITabBarDelegate, CAPSPageMenuDelegate{

    @IBOutlet weak var tabBarView: UITabBar!
     var pageMenu: CAPSPageMenu?
    
    @IBOutlet weak var serviceItem: UITabBarItem!
    @IBOutlet weak var diaryItem: UITabBarItem!
    @IBOutlet weak var journalItem: UITabBar!
    @IBOutlet weak var configureItem: UITabBarItem!
    @IBOutlet weak var historyImage: UITabBarItem!
    @IBOutlet weak var inforItem: UITabBarItem!
    var blockHiddenRightItemNav: (()->Void)?
    
    struct StaticSetting {
        static var instance: MainSettingViewController?
    }
    class var ShareInstance: MainSettingViewController {
        if StaticSetting.instance == nil {
            StaticSetting.instance = MainSettingViewController()
        }
        return StaticSetting.instance!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarView.delegate = self
        self.setUpTabBar()
        tabBarView.selectedItem = diaryItem
        StaticSetting.instance = self
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clickRightButtom() {
        if let block = blockHiddenRightItemNav {
            block()
        }
    }

    func setUpTabBar() {
        
        self.tabBarView.tintColor = UIColor.red
        
        let TimelineVC    = TimelineViewController()
        let ConfigureItem = ConfigComputerViewController()
        let ThumbnailVC   = ThumbnailViewController()
        let InforVC       = InforComputerViewController()
        let postNewVC     = PostViewController()

        let controllerArray = [ AVBaseNavigationController(rootViewController: TimelineVC),
                                AVBaseNavigationController(rootViewController: ConfigureItem),
                                AVBaseNavigationController(rootViewController: ThumbnailVC),
                                AVBaseNavigationController(rootViewController: postNewVC),
                                AVBaseNavigationController(rootViewController: InforVC)
                                ]
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor(hex: "313131")),
            .viewBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor(hex: "13b2e2")),
            .selectedMenuItemLabelColor(UIColor(hex: "13b2e2")),
            .addBottomMenuHairline(true),
            .menuItemFont(CCFont(.HiraKakuPro, .W6, 10)),
            .menuHeight(0),
            .selectionIndicatorHeight(0.0),
            .selectionIndicatorHeight(2.0),
            .bottomMenuHairlineColor(UIColor.clear),
            .centerMenuItems(true),
            .menuItemWidth(UIScreen.mainWidth/6),
            .menuMargin(1),
            .menuItemMargin(1)
        ]
        
        let heightTopView = self.tabBarView.frame.height + (self.navigationController?.navigationBar.layer.frame.height ?? 0) + self.heightStatusBar() + 3
        
        let framePapeMenu = CGRect(x: 0, y: heightTopView, width: self.view.bounds.width, height: self.view.bounds.height - heightTopView)
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: framePapeMenu, pageMenuOptions: parameters)
        pageMenu?.delegate = self
        if let pageMenu = pageMenu {
            self.view.addSubview(pageMenu.view)
        }
        
        
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        
        switch index {
        case 0:
            tabBarView.selectedItem = diaryItem
            MainSettingViewController.ShareInstance.navigationItem.rightBarButtonItem = nil
        case 1:
            tabBarView.selectedItem = configureItem
            MainSettingViewController.ShareInstance.navigationItem.rightBarButtonItem = nil
        case 2:
            tabBarView.selectedItem = historyImage
            MainSettingViewController.ShareInstance.navigationItem.rightBarButtonItem = nil
        case 3:
            tabBarView.selectedItem = serviceItem
                self.setRightBarIconParent()
        case 4:
            tabBarView.selectedItem = inforItem
            MainSettingViewController.ShareInstance.navigationItem.rightBarButtonItem = nil
        default:
            tabBarView.selectedItem = serviceItem
            MainSettingViewController.ShareInstance.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        if item.tag == 3 {
           self.setRightBarIconParent()
        } else {
           MainSettingViewController.ShareInstance.navigationItem.rightBarButtonItem = nil
        }
        pageMenu?.moveToPage(item.tag)
    }


}
