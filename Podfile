# Uncomment the next line to define a global platform for your project
platform :ios, '10.3'

target 'demo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for demo
  
  #pod 'Alps', :git => 'https://github.com/MatchMore/alps-ios-api.git', :tag => '0.0.3'
  #pod 'AlpsSDK', :git => 'https://github.com/MatchMore/alps-ios-sdk.git', :tag => '0.0.3'
pod 'Alps', :path => '../alps-ios-api'
pod 'AlpsSDK', :path => '../alps-ios-sdk'  

  target 'demoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'demoUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
