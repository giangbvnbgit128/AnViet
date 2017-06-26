//
//  AVImageChooseCollectionViewCell.swift
//  AnViet
//
//  Created by Bui Giang on 6/15/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class AVImageChooseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var btnDeleteImage: UIButton!
    @IBOutlet weak var imgImageView: UIImageView!
    var clickDeleteImageBlock: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(image:UIImage) {
        self.imgImageView.image = image
    }
    @IBAction func didSelectDeleteImage(_ sender: AnyObject) {
        if let block = clickDeleteImageBlock {
            block()
        }
    }
}
