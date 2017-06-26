platform :ios, '9.0'
use_frameworks!

target 'AnViet' do
  pod 'Alamofire', '~> 4.4'
  pod 'ObjectMapper'
  pod 'SDWebImage'
  pod 'SKPhotoBrowser'
  pod 'DKImagePickerController'
  pod 'ZKProgressHUD'
end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
