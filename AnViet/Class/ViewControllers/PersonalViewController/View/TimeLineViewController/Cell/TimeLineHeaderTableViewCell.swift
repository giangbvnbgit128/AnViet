//
//  TimeLineHeaderTableViewCell.swift
//  AnViet
//
//  Created by Bui Van Giang on 6/30/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class TimeLineHeaderTableViewCell: AVBaseTableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configCell(title:String) {
        self.lblTitle.text = title
    }
}
