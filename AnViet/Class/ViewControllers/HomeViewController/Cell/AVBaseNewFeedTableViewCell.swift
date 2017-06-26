//
//  AVBaseNewFeedTableViewCell.swift
//  AnViet
//
//  Created by Bui Giang on 6/11/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class AVBaseNewFeedTableViewCell: AVBaseTableViewCell {
//    var host:String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configCell(data:DataForItem, host:String,vc: UIViewController) {
        
    }
    func loadImage(url:String, complete: ((UIImage) -> Void)? ) {
        let url = URL(string: url)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                var imageData:UIImage = UIImage(named: "no_image.png")!
                if data != nil && UIImage(data: data!) != nil {
                 imageData = UIImage(data: data!)!
                }
                if let rs = complete {
                    return rs(imageData)
                }
            }
        }
    }
    func getArrayImageLoadFromUrl(arrayImageItem:[ImageItem],host: String, completed: (([UIImage])->Void)?) {
        var arrayImage:[UIImage] = []
        for i in 0..<arrayImageItem.count {
             self.loadImage(url:host + arrayImageItem[i].urlImage, complete: { (image) in
                arrayImage.append(image)
                if arrayImage.count == arrayImageItem.count {
                    if let rs = completed {
                        return rs(arrayImage)
                    }
                }
                
             })
        } 
    }
}
