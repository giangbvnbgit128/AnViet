//
//  InforTableViewCell.swift
//  AnViet
//
//  Created by Bui Giang on 7/1/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class InforTableViewCell: AVBaseTableViewCell {

    @IBOutlet weak var lbltitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(title:String) {
        self.lbltitle.text = title
    }
}
