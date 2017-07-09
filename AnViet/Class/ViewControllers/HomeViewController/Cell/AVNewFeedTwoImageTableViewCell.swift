//
//  AVNewFeedTwoImageTableViewCell.swift
//  AnViet
//
//  Created by Bui Giang on 5/30/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import SKPhotoBrowser
class AVNewFeedTwoImageTableViewCell: AVBaseNewFeedTableViewCell {

    @IBOutlet weak var imgAvarta: UIImageView!
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    var images = [SKPhoto]()
    var supperViewVC:UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
    self.lblDetail.textColor = UIColor.gray
    let tapRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.tapImg1))
        self.img1.addGestureRecognizer(tapRecognizer)
    let tapRecognizer2 = UITapGestureRecognizer( target: self, action: #selector(self.tapImg2))
        self.img2.addGestureRecognizer(tapRecognizer2)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func tapImg1() {
        if images.count >= 1 {
            let browser = SKPhotoBrowser(photos: images)
            browser.initializePageIndex(0)
            self.supperViewVC?.present(browser, animated: true, completion: {})
        }
    }
    
    func tapImg2() {
        if images.count >= 2 {
            let browser = SKPhotoBrowser(photos: images)
            browser.initializePageIndex(1)
            self.supperViewVC?.present(browser, animated: true, completion: {})
        }
    }
    
    override func configCell(data: DataForItem, host: String, vc: UIViewController) {
        self.supperViewVC = vc
        self.images.removeAll()
        self.lblTitle.text = data.post.title
        self.lblDetail.text = data.post.createdDate.dateFormUp()
        self.lblDescription.text = data.post.content
        self.btnLike.setTitle(data.post.userLike, for: .normal)
        self.imgAvarta.sd_setImage(with: URL(string: host + data.user.avartar), placeholderImage: UIImage(named: "icon_avatar.png"))
        self.img1.sd_setImage(with: URL(string: host + data.post.image[0].urlImage), placeholderImage: UIImage(named: "PlaceHolder.png"), options: []) { (someImage, someError, type, urlImage) in
            var photo:SKPhoto?
            if someImage != nil {
                photo = SKPhoto.photoWithImage(someImage!)
            } else {
                photo = SKPhoto.photoWithImage(UIImage(named: "PlaceHolder.png")!)
            }
            self.images.append(photo!)
        }
        self.img2.sd_setImage(with: URL(string: host + data.post.image[1].urlImage), placeholderImage: UIImage(named: "PlaceHolder.png"), options: []) { (someImage, someError, type, urlImage) in
            var photo:SKPhoto?
            if someImage != nil {
                photo = SKPhoto.photoWithImage(someImage!)
            } else {
                photo = SKPhoto.photoWithImage(UIImage(named: "PlaceHolder.png")!)
            }
            self.images.append(photo!)
        }
    }
    
}
