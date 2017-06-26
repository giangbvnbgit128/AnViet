//
//  AVTutorialViewController.swift
//  AnViet
//
//  Created by Bui Giang on 5/25/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class AVTutorialViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var btnRegis: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    let arrayImage:[String] = ["tutorial1","tutorial1","tutorial2","tutorial3",
                               "tutorial4","tutorial1","tutorial1","tutorial0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerNib(AVTutorialCollectionViewCell.self)
        self.automaticallyAdjustsScrollViewInsets = false
        self.pageControl.currentPage = 0
        self.btnLogin.layer.cornerRadius = 4
        self.btnRegis.layer.cornerRadius = 4
        self.pageControl.numberOfPages = arrayImage.count
        navigationController?.navigationBar.isTranslucent = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func movePageControlWithScroll () {
        let pageWidth = collectionView.frame.width
        let page = Int(floor((collectionView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        if pageControl.currentPage != page {
            self.pageControl.currentPage = page
        }
    }

    @IBAction func actionLogin(_ sender: AnyObject) {
        let logicVC = AVLoginViewController()
        navigationController?.pushViewController(logicVC, animated: true)
    }
    @IBAction func actionRegis(_ sender: AnyObject) {
        let regisVC = AVRegisterAccountAccountViewController()
        navigationController?.pushViewController(regisVC, animated: true)
    }
}

extension AVTutorialViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(AVTutorialCollectionViewCell.self, forIndexPath: indexPath) as AVTutorialCollectionViewCell
        cell.ConfigCell(nameImage: self.arrayImage[indexPath.row])
        return cell
    }
}

extension AVTutorialViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }

}
extension AVTutorialViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        movePageControlWithScroll()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        movePageControlWithScroll()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("====Scroll \(scrollView.contentOffset.x) prin y = \(scrollView.contentOffset.y)")
    }
}
