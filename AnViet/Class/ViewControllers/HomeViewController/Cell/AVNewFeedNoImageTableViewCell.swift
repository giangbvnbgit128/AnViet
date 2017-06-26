//
//  AVNewFeedNoImageTableViewCell.swift
//  AnViet
//
//  Created by Bui Giang on 6/11/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import SDWebImage

class AVNewFeedNoImageTableViewCell: AVBaseNewFeedTableViewCell {

    @IBOutlet weak var imgAvarta: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configCell(data:DataForItem, host:String, vc:UIViewController) {
        self.lblTitle.text = data.post.title
        self.lbldetail.text = data.post.createdDate
        self.lblDescription.text = data.post.content
        self.btnLike.setTitle(data.post.userLike, for: .normal)
        self.imgAvarta.sd_setImage(with: URL(string: host + data.user.avartar), placeholderImage: UIImage(named: "icon_avatar.png"))
    }
    
}
