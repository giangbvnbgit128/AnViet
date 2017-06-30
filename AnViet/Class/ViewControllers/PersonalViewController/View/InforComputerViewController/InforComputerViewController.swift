//
//  InforComputerViewController.swift
//  AnViet
//
//  Created by Bui Giang on 6/28/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class InforComputerViewController: AVBaseViewController {

    @IBOutlet weak var tableView: UITableView!

    var arrComptrName = ["Hãng sản xuất: ","Model: ","Màu sắc: ","Kích thước: ","Trọng lượng: ","Năm sản xuất: ","Ngày mua: ","Bảo hành: "]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCellNib(InforTableViewCell.self)
        self.tableView.registerCellNib(HeaderInforTableViewCell.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension InforComputerViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrComptrName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(InforTableViewCell.self)
        cell.configCell(title: self.arrComptrName[indexPath.row])
        return cell
    }
}
extension InforComputerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeue(HeaderInforTableViewCell.self)
        return cell
    }
}

