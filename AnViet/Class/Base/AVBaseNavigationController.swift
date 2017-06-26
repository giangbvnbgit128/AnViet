//
//  AVBaseNavigationController.swift
//  AnViet
//
//  Created by Bui Giang on 5/25/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class AVBaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? .portrait
    }
    override var shouldAutorotate : Bool {
        return self.topViewController?.shouldAutorotate ?? false
    }
}
