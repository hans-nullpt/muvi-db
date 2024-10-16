# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Muvi' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Muvi
  pod 'Alamofire'
  #  pod 'Moya', '~> 13.0.1'
  pod 'SnapKit', '~> 5.7.0'
  pod 'RxSwift', '6.8.0'
  pod 'RxCocoa', '6.8.0'
  # pod 'AlamofireObjectMapper', '~> 5.2'
  pod 'ObjectMapper'
end

post_install do |installer|
  installer.generated_projects.each do |project|
      project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
          end
      end
  end
end
