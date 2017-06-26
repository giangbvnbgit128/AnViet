//
//  ZKProgressHUD.swift
//  ZKProgressHUD
//
//  Created by 王文壮 on 2017/3/10.
//  Copyright © 2017年 WangWenzhuang. All rights reserved.
//

import UIKit

// MARK: - ZKProgressHUD
public class ZKProgressHUD: UIView {
    /// 全局中间变量
    fileprivate var hudType: HUDType!
    fileprivate var status: String?
    fileprivate var image: UIImage?
    fileprivate var gifUrl: URL?
    fileprivate var gifSize: CGFloat?
    fileprivate var progress: CGFloat?
    fileprivate var isShow: Bool = false
    
    fileprivate lazy var infoImage: UIImage? = ZKProgressHUDConfig.bundleImage(.info)?.withRenderingMode(.alwaysTemplate)
    fileprivate lazy var successImage: UIImage? = ZKProgressHUDConfig.bundleImage(.success)?.withRenderingMode(.alwaysTemplate)
    fileprivate lazy var errorImage: UIImage? = ZKProgressHUDConfig.bundleImage(.error)?.withRenderingMode(.alwaysTemplate)
    
    // MARK: - UI
    fileprivate lazy var screenView: UIView = {
        $0.frame = CGRect(x: 0, y: 0, width: self.screenWidht, height: self.screenHeight)
        $0.mask?.alpha = 0.3
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.alpha = 0.3
        $0.backgroundColor = ZKProgressHUDConfig.maskBackgroundColor
        return $0
    }(UIView())
    
    fileprivate lazy var contentView: UIView = {
        $0.layer.masksToBounds = true
        $0.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        $0.layer.cornerRadius = ZKProgressHUDConfig.cornerRadius
        $0.backgroundColor = ZKProgressHUDConfig.backgroundColor
        $0.alpha = 0
        return $0
    }(UIView())
    
    /// gif(ZKProgressHUDType)
    fileprivate lazy var gifView: ZKGifView = ZKGifView()
    
    /// image(ZKProgressHUDType)
    fileprivate lazy var imageView: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.tintColor = ZKProgressHUDConfig.foregroundColor
        return $0
    }(UIImageView())
    
    /// progress(ZKProgressHUDType)
    fileprivate lazy var progressView: ZKProgressView = {
        $0.progressColor = ZKProgressHUDConfig.foregroundColor
        $0.backgroundColor = .clear
        return $0
    }(ZKProgressView(frame: CGRect(x: 0, y: 0, width: 85, height: 85)))
    
    /// activityIndicator(ZKProgressHUDType)
    fileprivate var activityIndicatorView: UIView {
        get {
            return ZKProgressHUDConfig.animationStyle == AnimationStyle.circle ? self.circleHUDView : self.systemHUDView
        }
    }
    
    fileprivate lazy var systemHUDView: UIActivityIndicatorView = {
        $0.activityIndicatorViewStyle = .whiteLarge
        $0.color = ZKProgressHUDConfig.foregroundColor
        $0.sizeToFit()
        $0.startAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    fileprivate lazy var circleHUDView: UIView = {
        let lineWidth: CGFloat = 3
        let lineMargin: CGFloat = lineWidth / 2
        let arcCenter = CGPoint(x: $0.width / 2 - lineMargin, y: $0.height / 2 - lineMargin)
        let smoothedPath = UIBezierPath(arcCenter: arcCenter, radius: $0.width / 2 - lineWidth, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let layer = CAShapeLayer()
        layer.contentsScale = UIScreen.main.scale
        layer.frame = CGRect(x: lineMargin, y: lineMargin, width: arcCenter.x * 2, height: arcCenter.y * 2)
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = ZKProgressHUDConfig.foregroundColor.cgColor
        layer.lineWidth = 3
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinBevel
        layer.path = smoothedPath.cgPath
        
        layer.mask = CALayer()
        layer.mask?.contents = ZKProgressHUDConfig.bundleImage(.mask)?.cgImage
        layer.mask?.frame = layer.bounds

        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = (Double.pi * 2)
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float(Int.max)
        animation.autoreverses = false
        layer.add(animation, forKey: "rotate")
        
        $0.layer.addSublayer(layer)
        return $0
    }(UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 65)))
    
    fileprivate lazy var statusLabel: UILabel = {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = ZKProgressHUDConfig.font
        $0.textColor = ZKProgressHUDConfig.foregroundColor
        return $0
    }(UILabel())
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(ZKProgressHUD.observerDismiss), name: ZKProgressHUDConfig.ZKNSNotificationDismiss, object: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: ZKProgressHUDConfig.ZKNSNotificationDismiss, object: nil)
    }
}

// MARK: - 实例计算属性
extension ZKProgressHUD {
    fileprivate var screenWidht: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    
    fileprivate var screenHeight: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
    
    fileprivate var maxContentViewWidth: CGFloat {
        get {
            return self.screenWidht - ZKProgressHUDConfig.margin * 2
        }
    }
    
    fileprivate var maxContentViewChildWidth: CGFloat {
        get {
            return self.screenWidht - ZKProgressHUDConfig.margin * 4
        }
    }
}

extension ZKProgressHUD {
    /// 显示
    fileprivate func show(hudType: HUDType,
                          status: String? = nil,
                          image: UIImage? = nil,
                          isAutoDismiss: Bool? = nil,
                          maskStyle: MaskStyle? = nil,
                          imageType: ImageType? = nil,
                          gifUrl: URL? = nil,
                          gifSize: CGFloat? = nil,
                          progress: CGFloat? = nil) {
        DispatchQueue.main.async {
            self.hudType = hudType
            self.status = status == "" ? nil : status
            self.image = image
            self.gifUrl = gifUrl
            self.gifSize = gifSize
            self.progress = progress ?? 0
            if let imgType = imageType {
                switch imgType {
                case .info:
                    self.image = self.infoImage
                case .error:
                    self.image = self.errorImage
                case .success:
                    self.image = self.successImage
                default: break
                }
            }
            if self.hudType == .progress {
                if let progressValue = self.progress {
                    self.progressView.progress = Double(progressValue)
                }
                if self.restorationIdentifier != ZKProgressHUDConfig.restorationIdentifier {
                    self.updateView(maskStyle: maskStyle)
                }
            } else {
                self.updateView(maskStyle: maskStyle)
            }
            
            self.updateFrame(maskStyle: maskStyle)
            if let autoDismiss = isAutoDismiss {
                if autoDismiss {
                    self.autoDismiss(delay: ZKProgressHUDConfig.autoDismissDelay)
                }
            }
        }
    }
    /// 更新视图
    fileprivate func updateView(maskStyle: MaskStyle?) {
        self.restorationIdentifier = ZKProgressHUDConfig.restorationIdentifier
        ZKProgressHUD.frontWindow?.addSubview(self)
        if (maskStyle ?? ZKProgressHUDConfig.maskStyle) == .visible {
            self.addSubview(self.screenView)
        }
        self.addSubview(self.contentView)

        self.contentView.addSubview(self.statusLabel)
        
        switch self.hudType! {
        case .gif:
            if let url = self.gifUrl {
                self.gifView.frame.size = CGSize(width: self.gifSize ?? 100, height: self.gifSize ?? 100)
                self.gifView.showGIFImage(gifUrl: url)
                self.contentView.addSubview(self.gifView)
            }
            break
        case .image:
            self.contentView.addSubview(self.imageView)
            break
        case .progress:
            self.contentView.addSubview(self.progressView)
            break
        case .activityIndicator:
            self.contentView.addSubview(self.activityIndicatorView)
        default: break
        }
    }
    /// 更新视图大小坐标
    fileprivate func updateFrame(maskStyle: MaskStyle?) {
        if self.hudType! == .gif {
            if self.gifView.width > self.maxContentViewChildWidth {
                self.gifView.frame.size = CGSize(width: self.maxContentViewChildWidth, height: self.maxContentViewChildWidth)
            }
        }
        if self.hudType! == .image {
            self.imageView.image = self.image
            self.imageView.sizeToFit()
            // 如果图片尺寸超过限定最大尺寸，将图片尺寸修改为限定最大尺寸
            if self.imageView.width > self.maxContentViewChildWidth {
                self.imageView.frame.size = CGSize(width: self.maxContentViewChildWidth, height: self.maxContentViewChildWidth)
            }
        }
        
        if let text = self.status {
            self.statusLabel.isHidden = false
            self.statusLabel.text = text
            self.statusLabel.frame.size = text.size(font: ZKProgressHUDConfig.font, size: CGSize(width: self.maxContentViewChildWidth, height: 400))
            self.statusLabel.sizeToFit()
        } else {
            self.statusLabel.frame.size = CGSize.zero
            self.statusLabel.isHidden = true
        }
        
        self.contentView.frame.size = {
            var width: CGFloat = 0
            switch self.hudType! {
            case .gif:
                width = (self.statusLabel.isHidden ? self.gifView.width : (self.gifView.width > self.statusLabel.width ? self.gifView.width : self.statusLabel.width)) + ZKProgressHUDConfig.margin * 2
            case .image:
                width = (self.statusLabel.isHidden ? self.imageView.width : (self.imageView.width > self.statusLabel.width ? self.imageView.width : self.statusLabel.width)) + ZKProgressHUDConfig.margin * 2
            case .message:
                width = self.statusLabel.width + ZKProgressHUDConfig.margin * 2
            case .progress:
                width = (self.statusLabel.isHidden ? self.progressView.width : (self.progressView.width > self.statusLabel.width ? self.progressView.width : self.statusLabel.width)) + ZKProgressHUDConfig.margin * 2
            case .activityIndicator:
                width = (self.statusLabel.isHidden ? self.activityIndicatorView.width : (self.activityIndicatorView.width > self.statusLabel.width ? self.activityIndicatorView.width : self.statusLabel.width)) + ZKProgressHUDConfig.margin * 2
            }
            
            var height: CGFloat = 0
            switch self.hudType! {
            case .gif:
                height = (self.statusLabel.isHidden ? self.gifView.height : (self.gifView.height + ZKProgressHUDConfig.margin + self.statusLabel.height)) + ZKProgressHUDConfig.margin * 2
            case .image:
                height = (self.statusLabel.isHidden ? self.imageView.height : (self.imageView.height + ZKProgressHUDConfig.margin + self.statusLabel.height)) + ZKProgressHUDConfig.margin * 2
            case .message:
                height = self.statusLabel.height + ZKProgressHUDConfig.margin * 2
            case .progress:
                height = (self.statusLabel.isHidden ? self.progressView.height : (self.progressView.height + ZKProgressHUDConfig.margin + self.statusLabel.height)) + ZKProgressHUDConfig.margin * 2
            case .activityIndicator:
                height = (self.statusLabel.isHidden ? self.activityIndicatorView.height : (self.activityIndicatorView.height + ZKProgressHUDConfig.margin + self.statusLabel.height)) + ZKProgressHUDConfig.margin * 2
            }
            
            return CGSize(width: width, height: height)
        }()
        
        switch self.hudType! {
        case .gif:
            self.gifView.frame.origin = {
                let x = (self.contentView.width - self.gifView.width) / 2
                let y = ZKProgressHUDConfig.margin
                return CGPoint(x: x, y: y)
            }()
            self.statusLabel.frame.origin = {
                let x = (self.contentView.width - self.statusLabel.width) / 2
                let y = self.gifView.y + self.gifView.height + ZKProgressHUDConfig.margin
                return CGPoint(x: x, y: y)
            }()
        case .image:
            self.imageView.frame.origin = {
                let x = (self.contentView.width - self.imageView.width) / 2
                let y = ZKProgressHUDConfig.margin
                return CGPoint(x: x, y: y)
            }()
            self.statusLabel.frame.origin = {
                let x = (self.contentView.width - self.statusLabel.width) / 2
                let y = self.imageView.y + self.imageView.height + ZKProgressHUDConfig.margin
                return CGPoint(x: x, y: y)
            }()
        case .message:
            self.statusLabel.frame.origin = {
                let x = (self.contentView.width - self.statusLabel.width) / 2
                let y = ZKProgressHUDConfig.margin
                return CGPoint(x: x, y: y)
            }()
        case .progress:
            self.progressView.frame.origin = {
                let x = (self.contentView.width - self.progressView.width) / 2
                let y = ZKProgressHUDConfig.margin
                return CGPoint(x: x, y: y)
            }()
            self.statusLabel.frame.origin = {
                let x = (self.contentView.width - self.statusLabel.width) / 2
                let y = self.progressView.y + self.progressView.height + ZKProgressHUDConfig.margin
                return CGPoint(x: x, y: y)
            }()
        case .activityIndicator:
            self.activityIndicatorView.frame.origin = {
                let x = (self.contentView.width - self.activityIndicatorView.width) / 2
                let y = ZKProgressHUDConfig.margin
                return CGPoint(x: x, y: y)
            }()
            self.statusLabel.frame.origin = {
                let x = (self.contentView.width - self.statusLabel.width) / 2
                let y = self.activityIndicatorView.y + self.activityIndicatorView.height + ZKProgressHUDConfig.margin
                return CGPoint(x: x, y: y)
            }()
        }
        
        let x = (self.screenWidht - self.contentView.width) / 2
        let y = (self.screenHeight - self.contentView.height) / 2
        if (maskStyle ?? ZKProgressHUDConfig.maskStyle) == .hide {
            self.frame = CGRect(x: x, y: y, width: self.contentView.width, height: self.contentView.height)
            self.contentView.frame.origin = CGPoint(x: 0, y: 0)
        } else {
            self.frame = CGRect(x: 0, y: 0, width: self.screenWidht, height: self.screenHeight)
            self.contentView.frame.origin = CGPoint(x: x, y: y)
        }
        
        if !self.isShow {
            self.animationShow(contentFrame: self.contentView.frame)
        }
    }
    /// 动画显示
    func animationShow(contentFrame: CGRect) {
        self.isShow = true
        switch ZKProgressHUDConfig.animationShowStyle {
        case .fade:
            self.contentView.alpha = 0
        case .zoom:
            self.contentView.alpha = 1
            self.contentView.frame = CGRect(x: self.screenWidht / 2, y: contentFrame.origin.y, width: 0, height: contentFrame.size.height)
        case .flyInto:
            self.contentView.alpha = 1
            self.contentView.frame = CGRect(x: contentFrame.origin.x, y: 0 - contentFrame.size.height, width: contentFrame.size.width, height: contentFrame.size.height)
            break
        }
        UIView.animate(withDuration: 0.3, animations: {
            switch ZKProgressHUDConfig.animationShowStyle {
            case .fade:
                self.contentView.alpha = 1
            case .zoom:
                self.contentView.frame = contentFrame
            case .flyInto:
                self.contentView.frame = contentFrame
                break
            }
        })
    }
    /// 动画移除
    func animationDsmiss() {
        UIView.animate(withDuration: 0.3, animations: {
            switch ZKProgressHUDConfig.animationShowStyle {
            case .fade:
                self.contentView.alpha = 0
            case .zoom:
                self.contentView.frame = CGRect(x: self.screenWidht / 2, y: self.contentView.y, width: 0, height: self.contentView.height)
            case .flyInto:
                self.contentView.frame = CGRect(x: self.contentView.x, y: 0 - self.contentView.height, width: self.contentView.width, height: self.contentView.height)
                break
            }
        }, completion: { (finished) in
            self.isShow = false
            self.removeFromSuperview()
        })
    }
    /// 通知移除
    @objc fileprivate func observerDismiss(notification: Notification) {
        if let userInfo = notification.userInfo {
            let delay = userInfo["delay"] as! Int
            self.autoDismiss(delay: delay)
        } else {
            self.isShow = false
            self.removeFromSuperview()
        }
    }
    /// 自动移除
    fileprivate func autoDismiss(delay: Int) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + .seconds(delay), execute: {
            DispatchQueue.main.async {
                self.animationDsmiss()
            }
        })
    }
}

// MARK: - 类计算属性
extension ZKProgressHUD {
    fileprivate static var frontWindow: UIWindow? {
        get {
            let window = UIApplication.shared.windows.reversed().first(where: {
                $0.screen == UIScreen.main &&
                    !$0.isHidden && $0.alpha > 0 &&
                    $0.windowLevel >= UIWindowLevelNormal
            })
            return window
        }
    }
    
    static var shared: ZKProgressHUD {
        get {
            return ZKProgressHUD(frame: UIScreen.main.bounds)
        }
    }
}

// MARK: - 类方法
extension ZKProgressHUD {
    // 显示gif加载
    public static func showGif(gifUrl: URL?, gifSize: CGFloat?) {
        ZKProgressHUD.showGif(status: nil, gifUrl: gifUrl, gifSize: gifSize)
    }
    public static func showGif(status: String?, gifUrl: URL?, gifSize: CGFloat?) {
        ZKProgressHUD.showGif(status: status, gifUrl: gifUrl, gifSize: gifSize, maskStyle: nil)
    }
    public static func showGif(status: String?, gifUrl: URL?, gifSize: CGFloat?, maskStyle: ZKProgressHUDMaskStyle?) {
        shared.show(hudType: .gif, status: status, maskStyle: maskStyle, gifUrl: gifUrl, gifSize: gifSize)
    }
    
    // 显示图片
    public static func showImage(_ image: UIImage?) {
        ZKProgressHUD.showImage(image: image, status: nil)
    }
    public static func showImage(image: UIImage?, status: String?) {
        ZKProgressHUD.showImage(image: image, status: status, maskStyle: nil)
    }
    public static func showImage(image: UIImage?, status: String?, maskStyle: ZKProgressHUDMaskStyle?) {
        shared.show(hudType: .image, status: status, image: image, isAutoDismiss: true, maskStyle: maskStyle)
    }
    
    // 显示消息
    public static func showMessage(_ message: String?) {
        ZKProgressHUD.showMessage(message: message, maskStyle: nil)
    }
    public static func showMessage(message: String?, maskStyle: ZKProgressHUDMaskStyle?) {
        shared.show(hudType: .message, status: message, isAutoDismiss: true, maskStyle: maskStyle)
    }
    
    // 显示进度
    public static func showProgress(_ progress: CGFloat?) {
        ZKProgressHUD.showProgress(progress, status: nil)
    }
    public static func showProgress(_ progress: CGFloat?, status: String?) {
        ZKProgressHUD.showProgress(progress: progress, status: status, maskStyle: nil)
    }
    public static func showProgress(progress: CGFloat?, status: String?, maskStyle: ZKProgressHUDMaskStyle?) {
        var isShowProgressView = false
        for subview in (ZKProgressHUD.frontWindow?.subviews)! {
            if subview.isKind(of: ZKProgressHUD.self) && subview.restorationIdentifier == ZKProgressHUDConfig.restorationIdentifier {
                let progressHUD = subview as! ZKProgressHUD
                if progressHUD.hudType == .progress {
                    progressHUD.show(hudType: .progress, status: status, maskStyle: maskStyle, progress: progress)
                    isShowProgressView = true
                } else {
                    progressHUD.removeFromSuperview()
                }
            }
        }
        if !isShowProgressView {
            shared.show(hudType: .progress, status: status, maskStyle: maskStyle, progress: progress)
        }
    }
    
    // 显示加载
    public static func show() {
        ZKProgressHUD.show(nil)
    }
    public static func show(_ status: String?) {
        ZKProgressHUD.show(status: status, maskStyle: nil)
    }
    public static func show(status: String?, maskStyle: ZKProgressHUDMaskStyle?) {
        shared.show(hudType: .activityIndicator, status: status, maskStyle: maskStyle)
    }
    
    // 显示普通信息
    public static func showInfo(_ status: String?) {
        ZKProgressHUD.showInfo(status: status, maskStyle: nil)
    }
    public static func showInfo(status: String?, maskStyle: ZKProgressHUDMaskStyle?) {
        shared.show(hudType: .image, status: status, isAutoDismiss: true, maskStyle: maskStyle, imageType: .info)
    }
    
    // 显示成功信息
    public static func showSuccess(_ status: String?) {
        ZKProgressHUD.showSuccess(status: status, maskStyle: nil)
    }
    public static func showSuccess(status: String?, maskStyle: ZKProgressHUDMaskStyle?) {
        shared.show(hudType: .image, status: status, isAutoDismiss: true, maskStyle: maskStyle, imageType: .success)
    }
    
    // 显示失败信息
    public static func showError(_ status: String?) {
        ZKProgressHUD.showError(status: status, maskStyle: nil)
    }
    public static func showError(status: String?, maskStyle: ZKProgressHUDMaskStyle?) {
        shared.show(hudType: .image, status: status, isAutoDismiss: true, maskStyle: maskStyle, imageType: .error)
    }
    
    // 移除
    @available(swift, deprecated: 3.0, message: "请使用 dismiss 方法")
    public static func hide(delay: Int? = nil) {
        ZKProgressHUD.dismiss(delay)
    }
    public static func dismiss(_ delay: Int? = nil) {
        NotificationCenter.default.post(name: ZKProgressHUDConfig.ZKNSNotificationDismiss, object: nil, userInfo: ["delay" : delay ?? 0])
    }
    
    // 设置遮罩样式
    public static func setMaskStyle (_ maskStyle: ZKProgressHUDMaskStyle) {
        ZKProgressHUDConfig.maskStyle = maskStyle
    }
    
    // 设置动画显示/隐藏样式
    public static func setAnimationShowStyle (_ animationShowStyle: ZKProgressHUDAnimationShowStyle) {
        ZKProgressHUDConfig.animationShowStyle = animationShowStyle
    }
    
    // 设置遮罩背景色
    public static func setMaskBackgroundColor(_ color: UIColor) {
        ZKProgressHUDConfig.maskBackgroundColor = color
    }
    
    // 设置前景色
    public static func setForegroundColor(_ color: UIColor) {
        ZKProgressHUDConfig.foregroundColor = color
    }
    
    // 设置背景色
    public static func setBackgroundColor(_ color: UIColor) {
        ZKProgressHUDConfig.backgroundColor = color
    }
    
    // 设置字体
    public static func setFont(_ font: UIFont) {
        ZKProgressHUDConfig.font = font
    }
    
    // 设置圆角
    public static func setCornerRadius(_ cornerRadius: CGFloat) {
        ZKProgressHUDConfig.cornerRadius = cornerRadius
    }
    
    // 设置加载动画样式动画样式
    public static func setAnimationStyle(_ animationStyle: ZKProgressHUDAnimationStyle) {
        ZKProgressHUDConfig.animationStyle  = animationStyle
    }
    
    // 设置自动隐藏延时秒数
    public static func setAutoDismissDelay(_ autoDismissDelay: Int) {
        ZKProgressHUDConfig.autoDismissDelay = autoDismissDelay
    }
}
