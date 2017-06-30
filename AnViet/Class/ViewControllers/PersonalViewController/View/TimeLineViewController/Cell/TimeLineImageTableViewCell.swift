//
//  TimeLineImageTableViewCell.swift
//  AnViet
//
//  Created by Bui Van Giang on 6/30/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class TimeLineImageTableViewCell: AVBaseTableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lbltitle: UILabel!
    var arrayImage:[ImageItem] = []
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configCell(title:String,arrImage:[ImageItem]) {
        self.lbltitle.text = title
        self.arrayImage = arrImage
    }
}
extension TimeLineImageTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(TimeLineImageCollectionViewCell.self, forIndexPath: indexPath) as TimeLineImageCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayImage.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
extension TimeLineImageTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.height, height: self.collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
