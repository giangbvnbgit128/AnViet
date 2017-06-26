//
//  AVNewFeedFiveImageTableViewCell.swift
//  AnViet
//
//  Created by Bui Giang on 5/30/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import SDWebImage
import SKPhotoBrowser

class AVNewFeedFiveImageTableViewCell: AVBaseNewFeedTableViewCell {

    @IBOutlet weak var imgAvarta: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    
    var images = [SKPhoto]()
    var supperViewVC:UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.tapImg1))
        self.img1.addGestureRecognizer(tapRecognizer)
        
        let tapRecognizer2 = UITapGestureRecognizer( target: self, action: #selector(self.tapImg2))
        self.img2.addGestureRecognizer(tapRecognizer2)
        
        let tapRecognizer3 = UITapGestureRecognizer( target: self, action: #selector(self.tapImg3))
        self.img3.addGestureRecognizer(tapRecognizer3)
        let tapRecognizer4 = UITapGestureRecognizer( target: self, action: #selector(self.tapImg4))
        self.img4.addGestureRecognizer(tapRecognizer4)
        let tapRecognizer5 = UITapGestureRecognizer( target: self, action: #selector(self.tapImg5))
        self.img5.addGestureRecognizer(tapRecognizer5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func tapImg1() {
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        self.supperViewVC?.present(browser, animated: true, completion: {})
    }
    
    func tapImg2() {
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(1)
        self.supperViewVC?.present(browser, animated: true, completion: {})
    }
    
    func tapImg3() {
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(2)
        self.supperViewVC?.present(browser, animated: true, completion: {})
    }
    func tapImg4() {
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(3)
        self.supperViewVC?.present(browser, animated: true, completion: {})
    }
    func tapImg5() {
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(4)
        self.supperViewVC?.present(browser, animated: true, completion: {})
    }

    override func configCell(data: DataForItem, host: String,vc:UIViewController) {
        self.supperViewVC = vc
        self.images.removeAll()
        self.lblTitle.text = data.post.title
        self.lblDetail.text = data.post.createdDate
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
        self.img2.sd_setImage(with: URL(string: host + data.post.image[1].urlImage), placeholderImage: UIImage(named: "no_image.png"), options: []) { (someImage, someError, type, urlImage) in
            var photo:SKPhoto?
            if someImage != nil {
                photo = SKPhoto.photoWithImage(someImage!)
            } else {
                photo = SKPhoto.photoWithImage(UIImage(named: "no_image.png")!)
            }
            self.images.append(photo!)
        }
        self.img3.sd_setImage(with: URL(string: host + data.post.image[2].urlImage), placeholderImage: UIImage(named: "no_image.png"), options: []) { (someImage, someError, type, urlImage) in
            var photo:SKPhoto?
            if someImage != nil {
                photo = SKPhoto.photoWithImage(someImage!)
            } else {
                photo = SKPhoto.photoWithImage(UIImage(named: "no_image.png")!)
            }
            self.images.append(photo!)
        }
        self.img4.sd_setImage(with: URL(string: host + data.post.image[3].urlImage), placeholderImage: UIImage(named: "no_image.png"), options: []) { (someImage, someError, type, urlImage) in
            var photo:SKPhoto?
            if someImage != nil {
                photo = SKPhoto.photoWithImage(someImage!)
            } else {
                photo = SKPhoto.photoWithImage(UIImage(named: "no_image.png")!)
            }
            self.images.append(photo!)
        }
        self.img5.sd_setImage(with: URL(string: host + data.post.image[4].urlImage), placeholderImage: UIImage(named: "no_image.png"), options: []) { (someImage, someError, type, urlImage) in
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
