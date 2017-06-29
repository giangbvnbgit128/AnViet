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
    
    @IBOutlet weak var journalItem: UITabBar!
    @IBOutlet weak var configureItem: UITabBarItem!
    @IBOutlet weak var historyImage: UITabBarItem!
    @IBOutlet weak var inforItem: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUpTabBar() {
        
        self.tabBarView.tintColor = UIColor.red
        
        let HomeVC      = AVHomeViewController()
        let NewsVC      = AVNewsViewController()
        let ServiceVC   = AVServiceViewController()
        let PersonalVC  = AVPersonalViewController()
        let controllerArray = [ AVBaseNavigationController(rootViewController: HomeVC),
                                AVBaseNavigationController(rootViewController: NewsVC),
                                AVBaseNavigationController(rootViewController: ServiceVC),
                                AVBaseNavigationController(rootViewController: PersonalVC)]
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
        
        let heightTopView = self.heightStatusBar() + self.tabBarView.frame.height + 10
        
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
            tabBarView.selectedItem = configureItem
        case 1:
            tabBarView.selectedItem = UITabBar
        case 2:
            tabBarView.selectedItem = historyImage
        default:
            tabBarView.selectedItem = personalItem
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        pageMenu?.moveToPage(item.tag)
    }


}
