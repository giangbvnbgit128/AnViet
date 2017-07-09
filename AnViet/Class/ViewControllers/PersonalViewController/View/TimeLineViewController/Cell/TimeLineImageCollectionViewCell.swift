//
//  TimeLineImageCollectionViewCell.swift
//  AnViet
//
//  Created by Bui Van Giang on 6/30/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import SDWebImage

class TimeLineImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgCell: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(url:String) {
       self.imgCell.sd_setImage(with: URL(string: url), placeholderImage: UIImage( named: "PlaceHolder.png"))
    }
}
