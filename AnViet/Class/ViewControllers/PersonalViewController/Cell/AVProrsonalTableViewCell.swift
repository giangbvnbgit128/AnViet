//
//  AVProrsonalTableViewCell.swift
//  AnViet
//
//  Created by Bui Giang on 6/9/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class AVProrsonalTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvarta: UIImageView!
    @IBOutlet weak var txttitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(title:String,image:String) {
        self.txttitle.text = title
        self.imgAvarta.image = UIImage(named: image)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
