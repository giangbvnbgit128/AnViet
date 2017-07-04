//
//  PostViewController.swift
//  AnViet
//
//  Created by Bui Giang on 6/14/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import DKImagePickerController
import Alamofire
import ObjectMapper




class PostViewController: AVBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtContent: UITextView!
    var pickerController = DKImagePickerController()
    var assets: [DKAsset]?
    var arrImage:[UIImage] = []
    var countImageLoadFinish:Int = 0
    var imageUploadData:ImageUpload = ImageUpload()
    var arrayImageJSON:[DataImageUpload] = []
    var user:UserInfor = UserInfor()
    var parentVC: MainSettingViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(AVImageChooseCollectionViewCell.self)
        
        self.navigationController?.isNavigationBarHidden = true
        // setup textView
        self.txtContent.layer.borderWidth = 1
        self.txtContent.layer.borderColor = UIColor.black.cgColor
        NotificationCenter.default.addObserver(self, selector: #selector(self.postAllNews), name: NSNotification.Name(rawValue: "postNews"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionPickUpImageView(_ sender: AnyObject) {
        self.showImagePicker()
    }
    
    func showImagePicker() {
        pickerController.defaultSelectedAssets = self.assets
        pickerController.showsCancelButton = true
        pickerController.showsEmptyAlbums = true
        pickerController.didCancel = { ()
            print("didCancel")
        }
        
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
            self.assets = assets
            guard self.assets != nil else {
                return
            }
            self.collectionView.reloadData()
          
            for i in 0..<assets.count {
                let imageAss = assets[i]
                imageAss.fetchOriginalImage(true, completeBlock: { (image, arrayData) in
                    if image == nil {
                        return
                    }
                   self.arrImage.append(image!)
                })
            }
            
        }
        appDelegate.window?.visibleViewController()?.present(pickerController, animated: true, completion: nil)
    }

// MARK: - Send Post News
    func postAllNews() {
        let content = self.txtContent.text ?? ""
        if content.characters.count == 0 {
            self.showAler(message: "Thiếu nội dung", title: "Lỗi")
            return
        }
        var arrayImageData:[Data] = []
        for i in 0..<arrImage.count {
            arrayImageData.append(UIImagePNGRepresentation(arrImage[i])!)
            
        }
        
        var params = [String:AnyObject]()
        if arrayImageData.count > 0 {
            params["image"] = arrayImageData[0] as AnyObject
        }
        
        for i in 0..<arrayImageData.count {
            
            DispatchQueue.global().async {
                self.upLoadImage(image: arrayImageData[i], complete: {
                    self.countImageLoadFinish += 1
                    if self.countImageLoadFinish == arrayImageData.count {
                        let strImage:String = self.formatJsonForUpload(arrayImage: self.arrayImageJSON)
                        self.postNews(image: strImage, content: content, complete: {
                            self.stopLoading()
                        })
                        
                        
                    }
                })
            }
        }
        if arrayImageData.count == 0 {
            self.postNews(image: "", content: content, complete: {
                self.stopLoading()
            })
        }

    }
    
    func postNews(image:String,content:String,complete: (()-> Void)) {
        self.showLoading()
        let value:NSObject =  UserDefaults[.userInfor] as! NSObject
        let newValue = value as? [String : AnyObject]
        user = Mapper<UserInfor>().map(JSONObject: newValue)!
        
        Alamofire.request(AVNewsPostRouter( endpoint: .PostNews(userId: user.data.id, token: user.data.token, image: image.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, content: content.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!))).responseJSON { (response) in
            self.stopLoading()
            switch response.result {
            case .success(let value):
                let newValue = value as? [String : AnyObject]
                let newsPost:NewsUpload = Mapper<NewsUpload>().map(JSONObject: newValue)!
                if newsPost.error.compare("FALSE") == .orderedSame {
                     self.navigationController?.popViewController(animated: true)
                } else {
                    self.showAler(message: newsPost.message, title: "Error")
                }
            case .failure(let error):
                print("Error Request = \(error)")
                break
            }
        }
    }
// MARK: - Fomart JSOn
    func formatJsonForUpload(arrayImage:[DataImageUpload]) -> String {
        var str:String = ""
         for i in 0..<arrayImage.count {
            let item = arrayImage[i]
            if i != 0 {
                str = str + ","
            }
            str = str + "\"\(item.imageId)\":\"\(item.url)\""
            }
            str = "{" + str + "}"
            return str
        }
    
    func upLoadImage(image:Data,complete: @escaping() -> Void) {
        self.showLoading()
        let parameters = [
            "image": "swift_file.jpeg"
        ]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for _ in 0..<self.arrImage.count {
                multipartFormData.append(image, withName: "image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
            }

            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: AVUploadRouter( endpoint: .UploadImage).getUrl())
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("==========progress \(progress)")
                })
                
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        
                        let newValue = value as? [String : AnyObject]
                        self.imageUploadData = Mapper<ImageUpload>().map(JSONObject: newValue)!
                        if self.imageUploadData.error.compare("FALSE") == .orderedSame {
                            self.arrayImageJSON.append(self.imageUploadData.data)
                            complete()
                        } else {
                            self.showAler(message: self.imageUploadData.message, title: "Error")
                            complete()
                        }
                        
                    case .failure(let _):
                        complete()
                        break
                    }
                }
                
            case .failure(let encodingError):
                print("====Error == \(encodingError)")
                break
                //print encodingError.description
            }
        }
    }
}

extension PostViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(AVImageChooseCollectionViewCell.self, forIndexPath: indexPath)
        cell?.configCell(image: arrImage[indexPath.row])
        cell!.clickDeleteImageBlock = {() in
            DispatchQueue.main.async {
                self.arrImage.remove(at: indexPath.row)
                self.collectionView.reloadData()
            }

        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.arrImage.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

}

extension PostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.collectionView.layer.bounds.height, height: self.collectionView.layer.bounds.height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}
