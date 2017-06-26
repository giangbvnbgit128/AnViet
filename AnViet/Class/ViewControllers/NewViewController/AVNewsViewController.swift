//
//  AVNewsViewController.swift
//  AnViet
//
//  Created by Bui Giang on 5/28/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class AVNewsViewController: AVBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(AVNewsTableViewCell.self)
        tableView.registerCellNib(AVHeaderNewsTableViewCell.self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension AVNewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (UIScreen.mainHeight/10) * 3
        } else {
            return 60 * Ratio.widthIPhone6
        }

    }
}
extension AVNewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeue(AVHeaderNewsTableViewCell.self)
            return cell
        } else {
            let cell = tableView.dequeue(AVNewsTableViewCell.self)
            return cell
        }

    }
    
}
