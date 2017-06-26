//
//  AVTutorialCollectionViewCell.swift
//  AnViet
//
//  Created by Bui Giang on 5/25/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class AVTutorialCollectionViewCell: AVBaseCollectionViewCell {

    @IBOutlet weak var imageViewTutorial: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func ConfigCell(nameImage: String) {
        self.imageViewTutorial.image = UIImage(named: nameImage)
    }
    
}
