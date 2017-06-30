//
//  InforComputerViewController.swift
//  AnViet
//
//  Created by Bui Giang on 6/28/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class ConfigComputerViewController: AVBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrCategories:[String] = ["CPU - Bộ vi xử lý","Cache - Bộ nhớ đệm","Mainboard - Bo mạch chính","RAM - Bộ nhớ trong","HDD - Ổ đĩa cứng","Display - Màn hình","VGA - Đồ họa","Audio - Âm thanh","ODD - Ổ đĩa quang","Internet - Giao tiếp mạng","Ports - Cổng mở rộng","Webcam","Battery - Pin","OS/Software - Hệ điều hành/Phần mềm"]
    
    var arr2:[[String]] = [["Dung lượng: ","Loại Cache: "],["Kênh âm thanh: ","Công nghệ: "],["Loại: ","Công nghệ: "],["Độ phân giải: ","Thông tin: "],["Loại pin: ","Thời gian hoạt động: "],["HĐH: ","Phần mềm: "]];
    var arr3:[[String]] = [["Chipset: ","Tốc độ Bus: ","Hỗ trợ RAM max: "],["Dung lượng: ","Loại: ","Bus: "],["Dung lượng: ","Loại: ","Tốc độ quay: "],["Chipset đồ họa: ","Kiểu thiết kế: ","Bộ nhớ đồ họa: "],["LAN: ","Wifi: ","Bluetooth: "]];
    var arr4:[[String]] = [["Hãng sản xuất: ","Công nghệ: ","Loại: ","Tốc độ: "],["Cảm ứng: ","Kích thước: ","Công nghệ: ","Độ phân giải: "]];
    var arr5:[[String]] = [["Display: Samsung Galaxy s7","eSATA: ","HDMI: ","USB: ","Headphone/Microphone: ","CardReader: "]];
    var array:[[String]] = [["Hãng sản xuất: Samsung Galaxy s7","Công nghệ: Samsung Galaxy s7","Loại: Samsung Galaxy s7","Tốc độ: Samsung Galaxy s7"],["Display: Samsung Galaxy s7","eSATA: Samsung Galaxy s7","HDMI: Samsung Galaxy s7","USB: Samsung Galaxy s7","Headphone/Microphone: Samsung Galaxy s7","CardReader: Samsung Galaxy s7"],["Độ phân giải: Samsung Galaxy s7","Thông tin: Samsung Galaxy s7"],["Loại pin: Samsung Galaxy s7","Thời gian hoạt động: Samsung Galaxy s7"],["HDH: Samsung Galaxy s7","Phần mêm: Samsung Galaxy s7"],["HDH: Samsung Galaxy s7","Phần mêm: Samsung Galaxy s7"],["HDH: Samsung Galaxy s7","Phần mêm: Samsung Galaxy s7"],["HDH: Samsung Galaxy s7","Phần mêm: Samsung Galaxy s7"],["HDH: Samsung Galaxy s7","Phần mêm: Samsung Galaxy s7"],["HDH: Samsung Galaxy s7","Phần mêm: Samsung Galaxy s7"],["HDH: Samsung Galaxy s7","Phần mêm: Samsung Galaxy s7"],["HDH: Samsung Galaxy s7","Phần mêm: Samsung Galaxy s7"],["HDH: Samsung Galaxy s7","Phần mêm: Samsung Galaxy s7"],["HDH: Samsung Galaxy s7","Phần mêm: Samsung Galaxy s7"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCellNib(configTableViewCell.self)
        self.tableView.registerCellNib(headerConfigTableViewCell.self)
        
        
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
extension ConfigComputerViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(configTableViewCell.self)
        cell.configCell(title: self.array[indexPath.section][indexPath.row])
        return cell
    }
}
extension ConfigComputerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeue(headerConfigTableViewCell.self)
        cell.configCell(title: self.arrCategories[section])
        return cell
    }
}

