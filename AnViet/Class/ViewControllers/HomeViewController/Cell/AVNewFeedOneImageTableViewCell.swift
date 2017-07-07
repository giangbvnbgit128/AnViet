//
//  AVNewFeedOneImageTableViewCell.swift
//  AnViet
//
//  Created by Bui Giang on 5/30/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import SDWebImage
import SKPhotoBrowser

class AVNewFeedOneImageTableViewCell: AVBaseNewFeedTableViewCell {
    @IBOutlet weak var imgAvarta: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    var supperViewVC:UIViewController?
    var urlImage1:String = ""
    var images = [SKPhoto]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.tapImg1))
        self.img1.addGestureRecognizer(tapRecognizer)
        
    }
    
    func tapImg1() {
        if images.count > 0 {
            let browser = SKPhotoBrowser(photos: images)
            browser.initializePageIndex(0)
            self.supperViewVC?.present(browser, animated: true, completion: {})
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   override func configCell(data: DataForItem, host: String, vc: UIViewController) {
        self.images.removeAll()
        self.supperViewVC = vc
        self.lblTitle.text = data.post.title
        self.lblDetail.text = data.post.createdDate.dateFormUp()
        self.lblDescription.text = data.post.content
        self.btnLike.setTitle(data.post.userLike, for: .normal)
        self.imgAvarta.sd_setImage(with: URL(string: host + data.user.avartar), placeholderImage: UIImage(named: "icon_avatar.png"))
        self.img1.sd_setImage(with: URL(string: host + data.post.image[0].urlImage), placeholderImage: UIImage(named: "no_image.png"), options: []) { (someImage, someError, type, urlImage) in
            var photo:SKPhoto?
            if someImage != nil {
                photo = SKPhoto.photoWithImage(someImage!)
            } else {
                photo = SKPhoto.photoWithImage(UIImage(named: "no_image.png")!)
            }
            self.images.append(photo!)
        }
    }
}
