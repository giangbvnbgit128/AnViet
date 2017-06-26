//
//  AVPersonalViewController.swift
//  AnViet
//
//  Created by Bui Giang on 5/28/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class AVPersonalViewController: AVBaseViewController {
    @IBOutlet weak var tablView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tablView.delegate = self
        self.tablView.dataSource = self
        self.tablView.registerCellNib(AVProrsonalTableViewCell.self)

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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(AVProrsonalTableViewCell.self)
        return cell
        
    }
    
}
